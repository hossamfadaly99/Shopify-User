//
//  PaymentMethodTableViewController.swift
//  Shopify User
//
//  Created by Hossam on 12/06/2023.
//

import UIKit

class PaymentMethodTableViewController: UITableViewController {

  @IBOutlet weak var cashCheckedImage: UIImageView!

  @IBOutlet weak var cardCheckedImage: UIImageView!


  override func viewDidLoad() {
        super.viewDidLoad()
    self.tableView.layer.cornerRadius = 16
    self.tableView.layer.borderWidth = 0.5
    }
    // MARK: - Table view data source

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)

    selectMethod(indexPath.row)

  }

  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    60
  }

  func selectMethod(_ index: Int){
    switch index {
    case 0:
      cashCheckedImage.isHidden = false
      cardCheckedImage.isHidden = true
    default:
      cashCheckedImage.isHidden = true
      cardCheckedImage.isHidden = false
    }
  }

}

