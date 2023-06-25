//
//  PriceRule.swift
//  Shopify User
//
//  Created by Hossam on 19/06/2023.
//

import Foundation

struct PriceRule: Codable {
    var id: Int?
    var valueType: String?
    var value: String?
    var customerSelection: String?
    var targetType: String?
    var targetSelection: String?
    var allocationMethod: String?
    var allocationLimit: String?
    var oncePerCustomer: Bool?
    var usageLimit: Int?
    var startsAt: String?
    var endsAt: String?
    var createdAt: String?
    var updatedAt: String?
    var entitledProductIDs: [Int]?
    var entitledVariantIDs: [Int]?
    var entitledCollectionIDs: [Int]?
    var entitledCountryIDs: [Int]?
    var prerequisiteProductIDs: [Int]?
    var prerequisiteVariantIDs: [Int]?
    var prerequisiteCollectionIDs: [Int]?
    var customerSegmentPrerequisiteIDs: [Int]?
    var prerequisiteCustomerIDs: [Int]?
    var prerequisiteSubtotalRange: String?
    var prerequisiteQuantityRange: String?
    var prerequisiteShippingPriceRange: String?
    var prerequisiteToEntitlementQuantityRatio: PrerequisiteEntitlementQuantityRatio?
    var prerequisiteToEntitlementPurchase: PrerequisiteEntitlementPurchase?
    var title: String?
    var adminGraphqlAPIID: String?

    enum CodingKeys: String, CodingKey {
        case id
        case valueType = "value_type"
        case value
        case customerSelection = "customer_selection"
        case targetType = "target_type"
        case targetSelection = "target_selection"
        case allocationMethod = "allocation_method"
        case allocationLimit = "allocation_limit"
        case oncePerCustomer = "once_per_customer"
        case usageLimit = "usage_limit"
        case startsAt = "starts_at"
        case endsAt = "ends_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case entitledProductIDs = "entitled_product_ids"
        case entitledVariantIDs = "entitled_variant_ids"
        case entitledCollectionIDs = "entitled_collection_ids"
        case entitledCountryIDs = "entitled_country_ids"
        case prerequisiteProductIDs = "prerequisite_product_ids"
        case prerequisiteVariantIDs = "prerequisite_variant_ids"
        case prerequisiteCollectionIDs = "prerequisite_collection_ids"
        case customerSegmentPrerequisiteIDs = "customer_segment_prerequisite_ids"
        case prerequisiteCustomerIDs = "prerequisite_customer_ids"
        case prerequisiteSubtotalRange = "prerequisite_subtotal_range"
        case prerequisiteQuantityRange = "prerequisite_quantity_range"
        case prerequisiteShippingPriceRange = "prerequisite_shipping_price_range"
        case prerequisiteToEntitlementQuantityRatio = "prerequisite_to_entitlement_quantity_ratio"
        case prerequisiteToEntitlementPurchase = "prerequisite_to_entitlement_purchase"
        case title
        case adminGraphqlAPIID = "admin_graphql_api_id"
    }
}

struct PriceRuleResponse: Codable {
    var priceRules: [PriceRule]

    enum CodingKeys: String, CodingKey {
        case priceRules = "price_rules"
    }
}

struct PrerequisiteEntitlementQuantityRatio: Codable {
    var prerequisiteQuantity: String?
    var entitledQuantity: String?

    enum CodingKeys: String, CodingKey {
        case prerequisiteQuantity = "prerequisite_quantity"
        case entitledQuantity = "entitled_quantity"
    }
}

struct PrerequisiteEntitlementPurchase: Codable {
    var prerequisiteAmount: String?

    enum CodingKeys: String, CodingKey {
        case prerequisiteAmount = "prerequisite_amount"
    }
}
