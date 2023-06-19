//
//  CurrencyModel.swift
//  Shopify User
//
//  Created by Hossam on 19/06/2023.
//

import Foundation

struct Currency: Codable {
    let success: Bool?
    let timestamp: Int?
    let base, date: String?
    let rates: [String: Double]?
}
