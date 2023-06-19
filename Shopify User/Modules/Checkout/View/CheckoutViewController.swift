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
  var totalAmountWithDelivery: Double {
    return amount + 20.0
  }

  @IBOutlet weak var summaryAmountLabel: UILabel!
  @IBOutlet weak var deliveryAmountLabel: UILabel!
  @IBOutlet weak var orderAmountLabel: UILabel!

  override func viewDidLoad() {
        super.viewDidLoad()
      self.navigationController?.navigationBar.isHidden = true
    orderAmountLabel.text = "\(amount)$"
    deliveryAmountLabel.text = "20$"
    summaryAmountLabel.text = "\(totalAmountWithDelivery)$"
      
      self.createOrder()
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
      self.navigationController?.popViewController(animated: true)
      // TODO: make the cart empty and send server req for payment
    }
  }

}
