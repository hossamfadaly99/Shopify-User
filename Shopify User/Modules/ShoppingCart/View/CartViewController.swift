//
//  CartViewController.swift
//  Shopify User
//
//  Created by Hossam on 04/06/2023.
//

import UIKit
import PKHUD

class CartViewController: UIViewController {

  var viewModel: CartViewModel!

  @IBOutlet weak var noItemsImage: UIImageView!
  @IBOutlet weak var totalPriceLabel: UILabel!
  @IBOutlet weak var tableView: UITableView!
  let defaults = UserDefaults.standard
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    HUD.show(.progress)
    viewModel.loadCartItems()
  }
  override func viewDidLoad() {
        super.viewDidLoad()
    //TODO save cart id in the customer
//1116795633956
    viewModel = CartViewModel(networkManager: NetworkManager(url: URLCreator().getEditCartURL(id: "1116795633956")))

    viewModel.bindDataToView = {
      HUD.hide(animated: true)
      self.tableView.reloadData()
      print("lrntkjnrkjnwklntk")
      self.totalPriceLabel.text = "$\(self.viewModel.subTotalPrice)"
    }

    viewModel.bindEmptyListToView = {
      HUD.hide(animated: true)
      if self.viewModel.isEmptyList {
        self.tableView.isHidden = true
        //show image
        self.noItemsImage.isHidden = false
      } else {
        self.tableView.isHidden = false
        //hide image
        self.noItemsImage.isHidden = true
      }
    }

        // Do any additional setup after loading the view.
    let cell = UINib(nibName: "CartItemCell", bundle: nil)
    tableView.register(cell, forCellReuseIdentifier: "CartItemCell")



//    viewModel.loadCartItems()

    }
    

  @IBAction func navigateToCheckout(_ sender: Any) {
    let storyboard = UIStoryboard(name: "CheckoutStoryboard", bundle: nil)
    let checkoutVC = storyboard.instantiateViewController(withIdentifier: "CheckoutViewController") as! CheckoutViewController

    var totalPrice = Double(totalPriceLabel.text?.dropFirst() ?? "0.0") ?? 0.0

    checkoutVC.line_Items = viewModel.cartArray
    checkoutVC.emptyCartProtocol = self
    checkoutVC.amount = totalPrice

    if totalPrice > 0.0 {
      self.navigationController?.pushViewController(checkoutVC, animated: true)
    } else {
      AlertCreator.showAlert(title: "Add Items!", message: "The amount should be at least \(currencySymbol) \(10 * currencyValue)", viewController: self)
    }
  }



}

extension CartViewController: UITableViewDelegate{}

extension CartViewController: UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel.cartArray.count
  }


  func numberOfSections(in tableView: UITableView) -> Int {
    1
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CartItemCell", for: indexPath) as! CartItemCell
    cell.vc = self

    cell.totalPrice = Double(self.totalPriceLabel.text?.dropFirst() ?? "0") ?? 0
    cell.getTotalPrice = {
//      self.viewModel.subTotalPrice = cell.totalPrice
//      self.viewModel.cartArray[indexPath.row].quantity = (cell.counter)
      print("krbtkuygeksreykvbuyj2222 \(cell.counter)")
      self.viewModel.cartUpdated.draft_order?.line_items?[indexPath.row].quantity = cell.counter
      self.totalPriceLabel.text = "$\(self.viewModel.subTotalPrice)"

      self.viewModel.updateCartItem(cartItem: self.viewModel.cartUpdated)
    }
    cell.deleteThisItem = {

      self.handleDeletion(index: indexPath.row)

    }
    makeTableCellCornerRadius(cell: cell)
    cell.setupUI()
    cell.loadData(item: viewModel.cartArray[indexPath.row])

    
    return cell

  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }

  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    handleDeletion(index: indexPath.row)
  }

  func handleDeletion(index: Int){
    let alert = UIAlertController(title: "Watch out!", message: "Are you sure you want to delete this item from the cart?", preferredStyle: .alert)
    let yesAction = UIAlertAction(title: "Yes", style: .default, handler: { _ in
      HUD.show(.progress)
      if self.viewModel.cartUpdated.draft_order?.line_items?.count ?? 1 > 1{
        self.viewModel.cartUpdated.draft_order?.line_items?.remove(at: index)
      } else {
        print("hghghghgghhg")
        self.viewModel.cartUpdated.draft_order?.line_items?.remove(at: index)
        print(self.viewModel.cartUpdated.draft_order?.line_items?.count)
        //empty
        self.viewModel.cartUpdated.draft_order?.line_items?.append(Line_items( variant_id: 45557911028004, quantity: 1))
        print(self.viewModel.cartUpdated.draft_order?.line_items)
        print(self.viewModel.cartUpdated.draft_order?.line_items?.count)
//        self.viewModel.cartUpdated.draftOrder?.lineItems[0].title = "dummy for ward"
        print(self.viewModel.cartUpdated.draft_order?.line_items?.first?.title)
      }
      print(self.viewModel.cartUpdated)
      self.viewModel.updateCartItem(cartItem: self.viewModel.cartUpdated)

    })
    let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
    alert.addAction(yesAction)
    alert.addAction(noAction)
    self.present(alert, animated: true, completion: nil)
  }


}

extension CartViewController: EmptyCartProtocol{
  func makeCartEmpty(){
    print("kjhbsrkjbhrtj")
    self.viewModel.cartUpdated.draft_order?.line_items = [Line_items( variant_id: 45557911028004, quantity: 1)]
    self.viewModel.updateCartItem(cartItem: viewModel.cartUpdated)
  }
}
