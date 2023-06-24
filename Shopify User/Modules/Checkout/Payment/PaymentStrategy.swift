//
//  PaymentStrategy.swift
//  Shopify User
//
//  Created by Hossam on 12/06/2023.
//

import Foundation
import PassKit
protocol PaymentStrategy{
  func pay(amount: Double, vc: UIViewController) -> (Bool, String)
}
