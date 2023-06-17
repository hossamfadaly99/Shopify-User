//
//  AddressDetailsViewController.swift
//  Shopify User
//
//  Created by Hossam on 18/06/2023.
//

import UIKit

class AddressDetailsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      self.navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
  @IBAction func navigateBack(_ sender: UIBarButtonItem) {
    self.navigationController?.popViewController(animated: true)
  }

}
