//
//  AddressTableViewController.swift
//  Shopify User
//
//  Created by Hossam on 17/06/2023.
//

import UIKit

class AddressViewController: UIViewController {

  @IBOutlet weak var tableview: UITableView!
  var viewModel: AddressViewModel!

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    viewModel.getAllAddresses()
  }

  override func viewDidLoad() {
        super.viewDidLoad()
      self.navigationController?.navigationBar.isHidden = true
    viewModel = AddressViewModel(networkManager: NetworkManager(url: URLCreator().getAddressURL(customerId: "6938863698212")))

    viewModel.changeAddressUI = {
      self.tableview.reloadData()
    }

    let cell = UINib(nibName: "AddressCell", bundle: nil)
    tableview.register(cell, forCellReuseIdentifier: "AddressCell")


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

  @IBAction func navigateToDetails(_ sender: Any) {
    let detailsVC = (self.storyboard?.instantiateViewController(identifier: "AddressDetailsViewController")) as! AddressDetailsViewController
//    detailsVC.isExistingAddress = false
    self.navigationController?.pushViewController(detailsVC, animated: true)
  }
  @IBAction func navigateBack(_ sender: UIBarButtonItem) {
    self.navigationController?.popViewController(animated: true)
  }


  // MARK: - Table view data source




    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AddressViewController: UITableViewDelegate{

}

extension AddressViewController: UITableViewDataSource{
  func numberOfSections(in tableView: UITableView) -> Int {
    1
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel.addressList.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "AddressCell", for: indexPath) as! AddressCell

  cell.loadAddressData(viewModel.addressList[indexPath.row])
    cell.addressDetailsProtocol = self
    return cell
  }


  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
        let alert = UIAlertController(title: "Deletion Alert", message: "Are you sure you want to delete this item?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: {_ in
            //delete
          self.viewModel.addressId = "\(self.viewModel.addressList[indexPath.row].id ?? 0)"
          print("kgjfx")
          print(self.viewModel.addressId)
          print(self.viewModel.addressList[indexPath.row].id)
          print(self.viewModel.addressList[indexPath.row])
          print(self.viewModel.addressList.count)
          self.viewModel.removeAddress()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
           present(alert, animated: true, completion: nil)
      } else if editingStyle == .insert {
          // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
      }
  }

  
}


extension AddressViewController: AddressDetailsProtocol{
  func navigateToDetails(address: Address_) {
    let detailsVC = self.storyboard?.instantiateViewController(identifier: "AddressDetailsViewController") as! AddressDetailsViewController
//    detailsVC.viewModel.addressRequest.address = address
    detailsVC.address = address
    print("aaaaaa \(address)")
    detailsVC.isExistingAddress = true
    self.navigationController?.pushViewController(detailsVC, animated: true)
    
  }


}
