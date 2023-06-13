//
//  PaymentContext.swift
//  Shopify User
//
//  Created by Hossam on 12/06/2023.
//

import Foundation
import UIKit
class PaymentContext{
  private var paymentStrategy: PaymentStrategy

  init(pyamentStrategy: PaymentStrategy) {
    self.paymentStrategy = pyamentStrategy
  }

  func setPaymentStrategy(paymentStrategy: PaymentStrategy){
    self.paymentStrategy = paymentStrategy
  }

  func makePayment(amount: Double, vc: UIViewController) -> (Bool, String){
    return paymentStrategy.pay(amount: amount, vc: vc)
  }
}
