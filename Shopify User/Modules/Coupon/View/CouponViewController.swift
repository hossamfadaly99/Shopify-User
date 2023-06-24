//
//  CouponViewController.swift
//  Shopify User
//
//  Created by Hossam on 23/06/2023.
//

import UIKit
import SnackBar

class CouponViewController: UIViewController {


  var viewModel: CouponViewModel!

  @IBOutlet weak var tableview: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
      viewModel = CouponViewModel()
      viewModel.bindCouponsToUI = {
        self.tableview.reloadData()
      }
      viewModel.getCoupons()

        // Do any additional setup after loading the view.
      let cell = UINib(nibName: "CouponCell", bundle: nil)
      tableview.register(cell, forCellReuseIdentifier: "CouponCell")

    }
    
  @IBAction func backBtnClick(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
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

extension CouponViewController: UITableViewDelegate {

}

extension CouponViewController: UITableViewDataSource {


  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    self.viewModel.savedCoupons.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CouponCell") as! CouponCell
    cell.setupUI(viewModel.savedCoupons[indexPath.row])
    cell.showSnackbar =  {
      SnackBar.make(in: self.view, message: "Coupon Copied", duration: .lengthShort).show()
    }
    return cell
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    82
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }

}
