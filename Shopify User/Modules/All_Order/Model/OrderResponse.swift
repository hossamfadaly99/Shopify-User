//
//  OrderResponse.swift
//  Shopify User
//
//  Created by Mac on 18/06/2023.
//

import Foundation

// MARK: - OrderResponse
struct OrderResponse: Codable {
    var orders: [Order]?
}
struct OrderResponsePost: Codable {
    var order: OrderPost?
}

struct OrderPost : Codable{
    var lineItems: [LineItem]?
    var customer: OrderCustomer?
    var shippingAddress: OrderAddress?
    var financialStatus: String?
    var discountCodes: [DiscountCode]?
}

// MARK: - Order
struct Order: Codable {
    var id: Int?
    var adminGraphqlAPIID: String?
    var appID: Int?
    var browserIP: String?
    var buyerAcceptsMarketing: Bool?
    var cancelReason, cancelledAt, cartToken, checkoutID: String?
    var checkoutToken, clientDetails, closedAt, company: String?
    var confirmed: Bool?
    var contactEmail: String?
    var createdAt: String?
    var currency: String?
    var currentSubtotalPrice: String?
    var currentSubtotalPriceSet: OrderSet?
    var currentTotalAdditionalFeesSet: String?
    var currentTotalDiscounts: String?
    var currentTotalDiscountsSet: OrderSet?
    var currentTotalDutiesSet: String?
    var currentTotalPrice: String?
    var currentTotalPriceSet: OrderSet?
    var currentTotalTax: String?
    var currentTotalTaxSet: OrderSet?
    var customerLocale, deviceID: String?
    var discountCodes: [DiscountCode]?
    var email: String?
    var estimatedTaxes: Bool?
    var financialStatus: String?
    var fulfillmentStatus, landingSite, landingSiteRef, locationID: String?
    var merchantOfRecordAppID: String?
    var name: String?
    var note: String?
    var noteAttributes: [String]?
    var number, orderNumber: Int?
    var orderStatusURL: String?
    var originalTotalAdditionalFeesSet, originalTotalDutiesSet: String?
    var paymentGatewayNames: [String]?
    var phone: String?
    var presentmentCurrency: String?
    var processedAt: String?
    var reference, referringSite, sourceIdentifier: String?
    var sourceName: String?
    var sourceURL: String?
    var subtotalPrice: String?
    var subtotalPriceSet: OrderSet?
    var tags: String?
    var taxLines: [String]?
    var taxesIncluded, test: Bool?
    var token, totalDiscounts: String?
    var totalDiscountsSet: OrderSet?
    var totalLineItemsPrice: String?
    var totalLineItemsPriceSet: OrderSet?
    var totalOutstanding, totalPrice: String?
    var totalPriceSet, totalShippingPriceSet: OrderSet?
    var totalTax: String?
    var totalTaxSet: OrderSet?
    var totalTipReceived: String?
    var totalWeight: Int?
    var updatedAt: String?
    var userID: String?
    var billingAddress: Address?
    var customer: OrderCustomer?
    var discountApplications, fulfillments: [String]?
    var lineItems: [LineItem]?
    var paymentTerms: String?
    var refunds: [String]?
    var shippingAddress: OrderAddress?
    var shippingLines: [String]?

    enum CodingKeys: String, CodingKey {
        case id
        case adminGraphqlAPIID = "admin_graphql_api_id"
        case appID = "app_id"
        case browserIP = "browser_ip"
        case buyerAcceptsMarketing = "buyer_accepts_marketing"
        case cancelReason = "cancel_reason"
        case cancelledAt = "cancelled_at"
        case cartToken = "cart_token"
        case checkoutID = "checkout_id"
        case checkoutToken = "checkout_token"
        case clientDetails = "client_details"
        case closedAt = "closed_at"
        case company, confirmed
        case contactEmail = "contact_email"
        case createdAt = "created_at"
        case currency
        case currentSubtotalPrice = "current_subtotal_price"
        case currentSubtotalPriceSet = "current_subtotal_price_set"
        case currentTotalAdditionalFeesSet = "current_total_additional_fees_set"
        case currentTotalDiscounts = "current_total_discounts"
        case currentTotalDiscountsSet = "current_total_discounts_set"
        case currentTotalDutiesSet = "current_total_duties_set"
        case currentTotalPrice = "current_total_price"
        case currentTotalPriceSet = "current_total_price_set"
        case currentTotalTax = "current_total_tax"
        case currentTotalTaxSet = "current_total_tax_set"
        case customerLocale = "customer_locale"
        case deviceID = "device_id"
        case discountCodes = "discount_codes"
        case email
        case estimatedTaxes = "estimated_taxes"
        case financialStatus = "financial_status"
        case fulfillmentStatus = "fulfillment_status"
        case landingSite = "landing_site"
        case landingSiteRef = "landing_site_ref"
        case locationID = "location_id"
        case merchantOfRecordAppID = "merchant_of_record_app_id"
        case name, note
        case noteAttributes = "note_attributes"
        case number
        case orderNumber = "order_number"
        case orderStatusURL = "order_status_url"
        case originalTotalAdditionalFeesSet = "original_total_additional_fees_set"
        case originalTotalDutiesSet = "original_total_duties_set"
        case paymentGatewayNames = "payment_gateway_names"
        case phone
        case presentmentCurrency = "presentment_currency"
        case processedAt = "processed_at"
        case reference
        case referringSite = "referring_site"
        case sourceIdentifier = "source_identifier"
        case sourceName = "source_name"
        case sourceURL = "source_url"
        case subtotalPrice = "subtotal_price"
        case subtotalPriceSet = "subtotal_price_set"
        case tags
        case taxLines = "tax_lines"
        case taxesIncluded = "taxes_included"
        case test, token
        case totalDiscounts = "total_discounts"
        case totalDiscountsSet = "total_discounts_set"
        case totalLineItemsPrice = "total_line_items_price"
        case totalLineItemsPriceSet = "total_line_items_price_set"
        case totalOutstanding = "total_outstanding"
        case totalPrice = "total_price"
        case totalPriceSet = "total_price_set"
        case totalShippingPriceSet = "total_shipping_price_set"
        case totalTax = "total_tax"
        case totalTaxSet = "total_tax_set"
        case totalTipReceived = "total_tip_received"
        case totalWeight = "total_weight"
        case updatedAt = "updated_at"
        case userID = "user_id"
        case billingAddress = "billing_address"
        case customer
        case discountApplications = "discount_applications"
        case fulfillments
        case lineItems = "line_items"
        case paymentTerms = "payment_terms"
        case refunds
        case shippingAddress = "shipping_address"
        case shippingLines = "shipping_lines"
    }
}
// MARK: - DiscountCode
struct DiscountCode: Codable {
    var code, amount, type: String?
}
// MARK: - Address
struct OrderAddress: Codable {
    var firstName, address1, phone, city: String?
    var zip, province, country, lastName: String?
    var address2, company: String?
    var latitude, longitude: Double?
    var name, countryCode, provinceCode: String?
    var id, customerID: Int?
    var countryName: String?
    var addressDefault: Bool?

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case address1, phone, city, zip, province, country
        case lastName = "last_name"
        case address2, company, latitude, longitude, name
        case countryCode = "country_code"
        case provinceCode = "province_code"
        case id
        case customerID = "customer_id"
        case countryName = "country_name"
        case addressDefault = "default"
    }
}


// MARK: - Set
struct OrderSet: Codable {
    var shopMoney, presentmentMoney: Money?

    enum CodingKeys: String, CodingKey {
        case shopMoney = "shop_money"
        case presentmentMoney = "presentment_money"
    }
}

// MARK: - Money
struct Money: Codable {
    var amount: String?
    var currencyCode: String?

    enum CodingKeys: String, CodingKey {
        case amount
        case currencyCode = "currency_code"
    }
}

// MARK: - Customer
struct OrderCustomer: Codable {
    var id: Int?
    var email: String?
    var acceptsMarketing: Bool?
    var createdAt, updatedAt: String?
    var firstName, lastName, state: String?
    var note: String?
    var verifiedEmail: Bool?
    var multipassIdentifier: String?
    var taxExempt: Bool?
    var phone: String?
    var emailMarketingConsent: OrderEmailMarketingConsent?
    var smsMarketingConsent: String?
    var tags: String?
    var currency: String?
    var acceptsMarketingUpdatedAt: String?
    var marketingOptInLevel: String?
    var taxExemptions: [String]?
    var adminGraphqlAPIID: String?
    var defaultAddress: OrderAddress?

    enum CodingKeys: String, CodingKey {
        case id, email
        case acceptsMarketing = "accepts_marketing"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case firstName = "first_name"
        case lastName = "last_name"
        case state, note
        case verifiedEmail = "verified_email"
        case multipassIdentifier = "multipass_identifier"
        case taxExempt = "tax_exempt"
        case phone
        case emailMarketingConsent = "email_marketing_consent"
        case smsMarketingConsent = "sms_marketing_consent"
        case tags, currency
        case acceptsMarketingUpdatedAt = "accepts_marketing_updated_at"
        case marketingOptInLevel = "marketing_opt_in_level"
        case taxExemptions = "tax_exemptions"
        case adminGraphqlAPIID = "admin_graphql_api_id"
        case defaultAddress = "default_address"
    }
}

// MARK: - EmailMarketingConsent
struct OrderEmailMarketingConsent: Codable {
    var state, optInLevel: String?
    var consentUpdatedAt: String?

    enum CodingKeys: String, CodingKey {
        case state
        case optInLevel = "opt_in_level"
        case consentUpdatedAt = "consent_updated_at"
    }
}

// MARK: - LineItem
struct LineItem: Codable {
    var id: Int?
    var adminGraphqlAPIID: String?
    var fulfillableQuantity: Int?
    var fulfillmentService: String?
    var fulfillmentStatus: String?
    var giftCard: Bool?
    var grams: Int?
    var name, price: String?
    var priceSet: OrderSet?
    var productExists: Bool?
    var productID: Int?
    var properties: [String]?
    var quantity: Int?
    var requiresShipping: Bool?
    var sku: String?
    var taxable: Bool?
    var title, totalDiscount: String?
    var totalDiscountSet: OrderSet?
    var variantID: Int?
    var variantInventoryManagement, variantTitle, vendor: String?
    var taxLines, duties, discountAllocations: [String]?

    enum CodingKeys: String, CodingKey {
        case id
        case adminGraphqlAPIID = "admin_graphql_api_id"
        case fulfillableQuantity = "fulfillable_quantity"
        case fulfillmentService = "fulfillment_service"
        case fulfillmentStatus = "fulfillment_status"
        case giftCard = "gift_card"
        case grams, name, price
        case priceSet = "price_set"
        case productExists = "product_exists"
        case productID = "product_id"
        case properties, quantity
        case requiresShipping = "requires_shipping"
        case sku, taxable, title
        case totalDiscount = "total_discount"
        case totalDiscountSet = "total_discount_set"
        case variantID = "variant_id"
        case variantInventoryManagement = "variant_inventory_management"
        case variantTitle = "variant_title"
        case vendor
        case taxLines = "tax_lines"
        case duties
        case discountAllocations = "discount_allocations"
    }
}
