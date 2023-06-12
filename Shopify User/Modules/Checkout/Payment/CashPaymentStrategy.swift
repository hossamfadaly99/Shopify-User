//
//  CashPaymentStrategy.swift
//  Shopify User
//
//  Created by Hossam on 12/06/2023.
//

import Foundation
import PassKit
class CashPaymentStrategy: PaymentStrategy{
  func getPaymentReq() -> PKPaymentRequest {
    return PKPaymentRequest()
  }

  func pay(amount: Double) -> Bool {
    print("done payment with cash")
    return true
  }
}
