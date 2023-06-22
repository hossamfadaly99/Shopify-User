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
  
    @IBOutlet weak var gestView: UIView!
    
    
    let defaults = UserDefaults.standard
 
    override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
        guard let state = UserDefaults.standard.string(forKey: Constants.KEY_USER_STATE) else{return}
        if(state == Constants.USER_STATE_GUEST){
            gestView.isHidden = false
        } else {
            gestView.isHidden = true
            HUD.show(.progress)
            viewModel.loadCartItems()
            
        }
  }
  override func viewDidLoad() {
        super.viewDidLoad()
  
    viewModel = CartViewModel(networkManager: NetworkManager(url: URLCreator().getEditCartURL(id: "\(cartId)")))
    viewModel.bindDataToView = {
      HUD.hide(animated: true)
      self.tableView.reloadData()
   //   print("lrntkjnrkjnwklntk12345")
    //  print(self.viewModel.subTotalPrice)
    //  print(currencyValue)
    //  print(currencyValue * self.viewModel.subTotalPrice)
    //  print("lrntkjnrkjnwklntk1234end")
      var afterCurrency = String(format: "\(currencySymbol) %.2f", self.viewModel.subTotalPrice * currencyValue)
      self.totalPriceLabel.text = "\(afterCurrency)"
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
    
    @IBAction func navigateToSign(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Signup_SB", bundle: nil)
        let nextViewController = storyboard.instantiateViewController(withIdentifier: Constants.SCREEN_ID_SIGNUP) as! Signup_VC
        nextViewController.modalPresentationStyle = .fullScreen
        present(nextViewController, animated: true)
    }
    
  @IBAction func navigateToCheckout(_ sender: Any) {
    let storyboard = UIStoryboard(name: "CheckoutStoryboard", bundle: nil)
    let checkoutVC = storyboard.instantiateViewController(withIdentifier: "CheckoutViewController") as! CheckoutViewController

    var totalPrice = Double(totalPriceLabel.text?.dropFirst(4) ?? "0.0") ?? 0.0

    checkoutVC.line_Items = viewModel.cartArray
    checkoutVC.emptyCartProtocol = self
    checkoutVC.amount = totalPrice //* currencyValue

    if totalPrice > 0.0 {
      self.navigationController?.pushViewController(checkoutVC, animated: true)
    } else {
      var afterCurrency = String(format: "%.2f \(currencySymbol)", 10 * currencyValue)
      AlertCreator.showAlert(title: "Add Items!", message: "The amount should be at least \(afterCurrency)", viewController: self)
    }
  }

  @IBAction func backBtnClick(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
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

    cell.totalPrice = Double(self.totalPriceLabel.text?.dropFirst(4) ?? "0") ?? 0
    cell.getTotalPrice = {
//      self.viewModel.subTotalPrice = cell.totalPrice
//      self.viewModel.cartArray[indexPath.row].quantity = (cell.counter)
  //    print("krbtkuygeksreykvbuyj2222 \(cell.counter)")
      self.viewModel.cartUpdated.draft_order?.line_items?[indexPath.row].quantity = cell.counter
  //    print(self.viewModel.subTotalPrice * currencyValue)
      self.totalPriceLabel.text = String(format: "\(currencySymbol) %.2f", self.viewModel.subTotalPrice * currencyValue)

//may bee problem
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
        self.viewModel.cartUpdated.draft_order?.line_items = [Line_items( title: "dummy", quantity: 1, price: "0")]
      }
    //  print(self.viewModel.cartUpdated)
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
   // print("kjhbsrkjbhrtj")
    self.viewModel.cartUpdated.draft_order?.line_items = [Line_items( title: "dummy", quantity: 1, price: "0")]
    self.viewModel.updateCartItem(cartItem: viewModel.cartUpdated)
  }
}
