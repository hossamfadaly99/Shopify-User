//
//  AddressDetailsViewController.swift
//  Shopify User
//
//  Created by Hossam on 18/06/2023.
//

import UIKit

class AddressDetailsViewController: UIViewController {


  @IBOutlet weak var address1TF: UITextField!
  @IBOutlet weak var address2TF: UITextField!
  @IBOutlet weak var cityTF: UITextField!
  @IBOutlet weak var phoneTF: UITextField!
  @IBOutlet weak var provinceTF: UITextField!
  @IBOutlet weak var countryTF: UITextField!

  var viewModel: AddressViewModel!
  var address: Address_?
  var isExistingAddress = false

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
//    viewModel.getAllAddresses()
    //display the data of an item

  }
  
    override func viewDidLoad() {
        super.viewDidLoad()
      self.navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.

      viewModel = AddressViewModel(networkManager: NetworkManager(url: URLCreator().getAddressURL(customerId: "6938863698212")))
      viewModel.addressRequest.address = address
      self.loadDetailsData()
      viewModel.changeAddressUI = {
        self.navigationController?.popViewController(animated: true)
      }
    }

  func loadDetailsData(){
    self.address1TF.text = address?.address1
    self.address2TF.text = address?.address2
    self.cityTF.text = address?.city
    self.phoneTF.text = address?.phone
    self.provinceTF.text = address?.province
    self.countryTF.text = address?.country
  }
    
  @IBAction func navigateBack(_ sender: UIBarButtonItem) {
    self.navigationController?.popViewController(animated: true)
  }

  @IBAction func confirmAddress(_ sender: Any) {
    let address = Address_(id: self.address?.id, address1: self.address1TF.text, address2: self.address2TF.text, city: self.cityTF.text, province: self.provinceTF.text, country: self.countryTF.text, phone: self.phoneTF.text)
    viewModel.addressRequest.address = address
    if !isExistingAddress{
      print("is existt: \(isExistingAddress)")
      viewModel.addAddress()
    } else {
      print("is existt: \(isExistingAddress)")
      viewModel.editAddress()
      print("mafrood true")
    }

  }
}
