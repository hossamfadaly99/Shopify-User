//
//  CartViewController.swift
//  Shopify User
//
//  Created by Hossam on 04/06/2023.
//

import UIKit

class CartViewController: UIViewController {

  var viewModel: CartViewModel!

  @IBOutlet weak var tableView: UITableView!
  override func viewDidLoad() {
        super.viewDidLoad()
    //TODO save cart id in the customer

    viewModel = CartViewModel(networkManager: NetworkManager(url: URLCreator().getCreateCartURL()))

    viewModel.bindDataToView = {
      self.tableView.reloadData()
    }

        // Do any additional setup after loading the view.
    let cell = UINib(nibName: "CartItemCell", bundle: nil)
    tableView.register(cell, forCellReuseIdentifier: "CartItemCell")



    viewModel.loadCartItems()

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CartViewController: UITableViewDelegate{



}

extension CartViewController: UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel.cartArray.count
  }


  func numberOfSections(in tableView: UITableView) -> Int {
    1
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CartItemCell", for: indexPath) as! CartItemCell

    makeTableCellCornerRadius(cell: cell)
    cell.setupUI()
    cell.loadData(item: viewModel.cartArray[indexPath.row])
    
    return cell

  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }





}
