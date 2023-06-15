//
//  CartViewController.swift
//  Shopify User
//
//  Created by Hossam on 04/06/2023.
//

import UIKit

class CartViewController: UIViewController {

  var viewModel: CartViewModel!

  @IBOutlet weak var totalPriceLabel: UILabel!
  @IBOutlet weak var tableView: UITableView!
  override func viewDidLoad() {
        super.viewDidLoad()
    //TODO save cart id in the customer

    viewModel = CartViewModel(networkManager: NetworkManager(url: URLCreator().getCreateCartURL()))

    viewModel.bindDataToView = {
      self.tableView.reloadData()
      print("lrntkjnrkjnwklntk")
      self.totalPriceLabel.text = "$\(self.viewModel.subTotalPrice)"
    }

    viewModel.bindEmptyListToView = {
      if self.viewModel.isEmptyList {
        self.tableView.isHidden = true
        //show image
      } else {
        self.tableView.isHidden = false
        //hide image
      }
    }

        // Do any additional setup after loading the view.
    let cell = UINib(nibName: "CartItemCell", bundle: nil)
    tableView.register(cell, forCellReuseIdentifier: "CartItemCell")



    viewModel.loadCartItems()

    }
    


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      let checkoutVC = segue.destination as! CheckoutViewController
      checkoutVC.amount = Double(totalPriceLabel.text?.dropFirst() ?? "0.0") ?? 0.0
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

    cell.totalPrice = Double(self.totalPriceLabel.text?.dropFirst() ?? "0") ?? 0
    cell.getTotalPrice = {
      self.viewModel.subTotalPrice = cell.totalPrice
      self.viewModel.cartArray[indexPath.row].quantity = (cell.counter)
      self.totalPriceLabel.text = "$\(self.viewModel.subTotalPrice)"
      self.viewModel.transferCartData()
      self.viewModel.updateCartItem(cartItem: self.viewModel.cartUpdated!)
    }
    makeTableCellCornerRadius(cell: cell)
    cell.setupUI()
    cell.loadData(item: viewModel.cartArray[indexPath.row])

    
    return cell

  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }





}
