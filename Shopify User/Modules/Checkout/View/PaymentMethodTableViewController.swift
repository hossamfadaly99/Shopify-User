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

    }
    // MARK: - Table view data source

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)

    selectMethod(indexPath.row)

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

