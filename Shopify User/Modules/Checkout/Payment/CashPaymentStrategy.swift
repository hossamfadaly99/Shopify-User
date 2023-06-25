//
//  CashPaymentStrategy.swift
//  Shopify User
//
//  Created by Hossam on 12/06/2023.
//

import Foundation
import PassKit
class CashPaymentStrategy: PaymentStrategy{

  func pay(amount: Double, vc: UIViewController) -> (Bool, String) {
    if amount < 500 * currencyValue {
      return (true, "Purchased successfully")
    } else {
      return (false, "The total amount is so big, please choose another payment method!")
    }

  }
}
