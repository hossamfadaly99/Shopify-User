//
//  Coupon.swift
//  Shopify User
//
//  Created by Hossam on 19/06/2023.
//

import Foundation

struct Coupon: Codable {
    var id: Int?
    var priceRuleID: Int?
    var code: String?
    var usageCount: Int?
    var createdAt: String?
    var updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case priceRuleID = "price_rule_id"
        case code
        case usageCount = "usage_count"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

struct CouponResponse: Codable {
    let discountCodes: [Coupon]

    enum CodingKeys: String, CodingKey {
        case discountCodes = "discount_codes"
    }
}
