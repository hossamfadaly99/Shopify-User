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
    request.supportedNetworks = [.visa, .masterCard, .girocard]
    request.supportedCountries = ["EG", "US"]
    request.merchantCapabilities = .capability3DS
    request.countryCode = "US"
    request.currencyCode = "USD"

    return request
  }()

  
  func pay(amount: Double, vc: UIViewController) -> (Bool, String) {
    paymentRequest.paymentSummaryItems = [PKPaymentSummaryItem(label: "Shopify Cart", amount: NSDecimalNumber(value: amount))]
    let controller = PKPaymentAuthorizationViewController(paymentRequest: paymentRequest)
    controller?.delegate = (vc as! any PKPaymentAuthorizationViewControllerDelegate)
    vc.present(controller!, animated: true)
    return (true, "trying payment")
  }
}


