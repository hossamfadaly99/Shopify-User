//
//  CheckoutViewController.swift
//  Shopify User
//
//  Created by Hossam on 12/06/2023.
//

import UIKit
import PassKit

class CheckoutViewController: UIViewController {
  var amount: Double = 0.0
    
    var viewModel : CheckoutViewModel?
    var line_Items: [Line_items] = []
    var emptyCartProtocol: EmptyCartProtocol!
    var totalAmountWithDelivery: Double {
    return amount + 20.0 * currencyValue
  }
  @IBOutlet weak var addressOneLabel: UILabel!
  @IBOutlet weak var addressTwoLabel: UILabel!


  @IBOutlet weak var summaryAmountLabel: UILabel!
  @IBOutlet weak var deliveryAmountLabel: UILabel!
  @IBOutlet weak var orderAmountLabel: UILabel!

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    viewModel?.getDefaultAddress()
  }
  override func viewDidLoad() {
        super.viewDidLoad()
      self.navigationController?.navigationBar.isHidden = true
//    var afterCurrency = String(format: "%.2f \(currencySymbol)", amount * currencyValue)
    print("ltgblrtk")
    print(amount)
    var afterCurrency = String(format: "%.2f \(currencySymbol)", amount)
    orderAmountLabel.text = afterCurrency//"\(amount * currencyValue)\(currencySymbol)"
    afterCurrency = String(format: "%.2f \(currencySymbol)", 10 * currencyValue)
    deliveryAmountLabel.text = afterCurrency//"\(10 * currencyValue) \(currencySymbol)"
    afterCurrency = String(format: "%.2f \(currencySymbol)", totalAmountWithDelivery )
    summaryAmountLabel.text = afterCurrency//"\(totalAmountWithDelivery * currencyValue)\(currencySymbol)"
    viewModel = CheckoutViewModel(networkManager: NetworkManager(url: URLCreator().getCreateOrder()))
    viewModel?.transferObject(items: line_Items)
    viewModel?.getDefaultAddress()
    viewModel?.bindDefaultAddress = {
      var address = self.viewModel?.defaultAddress
      self.addressOneLabel.text = address?.address1
      self.addressTwoLabel.text = "\(address?.address2 ?? ""), \(address?.city ?? ""), \(address?.province ?? ""), \(address?.country ?? "")"
    }

    }

  @IBAction func backBtnClick(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
  }

  func isCardMethodSelected() -> Bool {
    if let cardImage = self.view.viewWithTag(2) as? UIImageView{
      if !cardImage.isHidden{
        return true
      }else {
        return false
      }
    }
    return false
  }
  @IBAction func purchaseBtnClick(_ sender: Any) {

    let paymentcontext = PaymentContext(pyamentStrategy: CashPaymentStrategy())

    if isCardMethodSelected(){
      paymentcontext.setPaymentStrategy(paymentStrategy: ApplePaymentStrategy())
    }

    let isPaymentSuccessful = paymentcontext.makePayment(amount: self.totalAmountWithDelivery, vc: self)

    if isPaymentSuccessful.0 {
      if isPaymentSuccessful.1 == "Purchased successfully"{
        //handle server side to make it order
        self.createOrder()
        self.emptyCartProtocol.makeCartEmpty()
        self.navigationController?.popViewController(animated: true)

      }
      print(isPaymentSuccessful.1)
    } else {
      print(isPaymentSuccessful.1)
    }
  }
  

}




extension CheckoutViewController: PKPaymentAuthorizationViewControllerDelegate{
  func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
    controller.dismiss(animated: true)
  }

  func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {

    let paymentAuthorizationResult = PKPaymentAuthorizationResult(status: .success, errors: nil)
    completion(paymentAuthorizationResult)
    if paymentAuthorizationResult.status == .failure{
      print("failed")
    }

    if paymentAuthorizationResult.status == .success{
      print("success")
      controller.dismiss(animated: true)
      self.createOrder()
      self.emptyCartProtocol.makeCartEmpty()
      self.navigationController?.popViewController(animated: true)
      // TODO: make the cart empty and send server req for payment
    }
  }

}
