//
//  PaymentStrategy.swift
//  Shopify User
//
//  Created by Hossam on 12/06/2023.
//

import Foundation
import PassKit

class ApplePaymentStrategy: PaymentStrategy{

  private var paymentRequest: PKPaymentRequest = {
    let request = PKPaymentRequest()
    request.merchantIdentifier = "merchant.com.fadaly.pay"
    request.supportedNetworks = [.visa, .masterCard]
    request.supportedCountries = ["EG", "US"]
    request.merchantCapabilities = .capability3DS
    request.countryCode = "US"
    request.currencyCode = "USD"

    request.paymentSummaryItems = [PKPaymentSummaryItem(label: "Iphone 14 pro max", amount: 42_000)]

    return request
  }()

  func getPaymentReq() -> PKPaymentRequest{
    return paymentRequest
  }
  
  func pay(amount: Double) -> Bool {
    paymentRequest.paymentSummaryItems = [PKPaymentSummaryItem(label: "Shopify Cart", amount: 135)]
//    var topCV = UIApplication.sharedApplication().keyWindow?.rootViewController?.presentedViewController
//    let topVC = (UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController?.presentedViewController)! as! CheckoutViewController

//    let controller = PKPaymentAuthorizationViewController(paymentRequest: paymentRequest)
//    controller?.delegate = topVC
//    topVC.present(controller!, animated: true){
//      print("presented")
//    }
    print("done payment from apple")
    return true
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
//      dismiss(animated: true)
      //make the cart empty and send server req for payment
    }
  }


}
