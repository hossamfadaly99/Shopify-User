////
////  AllDraftOrders.swift
////  Shopify User
////
////  Created by Hossam on 08/06/2023.
////
//
//import Foundation
//
//// MARK: - Welcome
//struct AllDraftOrders: Codable {
//    let draft_orders: [DraftOrder]?
//
//
//}
//
//// MARK: - DraftOrder
//struct DraftOrder: Codable {
//    let id: Int?
//    let note: String?
//    let email: String?
//    let taxesIncluded: Bool?
//    let currency: String?
//    let invoiceSentAt: String?
//    let createdAt, updatedAt: String?
//    let taxExempt: Bool?
//    let completedAt: String?
//    let name, status: String?
//    let lineItems: [LineItem]?
//    let shippingAddress, billingAddress: Address?
//    let invoiceURL: String?
//    let appliedDiscount: AppliedDiscount?
//    let orderID, shippingLine: String?
//    let taxLines: [TaxLine]?
//    let tags: String?
//    let noteAttributes: [String?]?
//    let totalPrice, subtotalPrice, totalTax: String?
//    let paymentTerms: String?
//    let adminGraphqlAPIID: String?
//    let customer: Customer?
//
//  enum CodingKeys: String, CodingKey {
//          case id, note, email
//          case taxesIncluded = "taxes_included"
//          case currency
//          case invoiceSentAt = "invoice_sent_at"
//          case createdAt = "created_at"
//          case updatedAt = "updated_at"
//          case taxExempt = "tax_exempt"
//          case completedAt = "completed_at"
//          case name, status
//          case lineItems = "line_items"
//          case shippingAddress = "shipping_address"
//          case billingAddress = "billing_address"
//          case invoiceURL = "invoice_url"
//          case appliedDiscount = "applied_discount"
//          case orderID = "order_id"
//          case shippingLine = "shipping_line"
//          case taxLines = "tax_lines"
//          case tags
//          case noteAttributes = "note_attributes"
//          case totalPrice = "total_price"
//          case subtotalPrice = "subtotal_price"
//          case totalTax = "total_tax"
//          case paymentTerms = "payment_terms"
//          case adminGraphqlAPIID = "admin_graphql_api_id"
//          case customer
//      }
//
//}
//
//// MARK: - AppliedDiscount
//struct AppliedDiscount: Codable {
//    let description, value, title, amount: String?
//    let valueType: String?
//
//  enum CodingKeys: String, CodingKey {
//          case description, value, title, amount
//          case valueType = "value_type"
//      }
//
//}
//
//// MARK: - Address
//struct Address: Codable {
//    let firstName: String?
//    let address1: String?
//    let phone: String?
//    let city: String?
//    let zip: String?
//    let province: String?
//    let country: String?
//    let lastName: String?
//    let address2, company, latitude, longitude: String?
//    let name: String?
//    let countryCode: String?
//    let provinceCode: String?
//    let id, customerID: Int?
//    let countryName: String?
//    let addressDefault: Bool?
//
//  enum CodingKeys: String, CodingKey {
//          case firstName = "first_name"
//          case address1, phone, city, zip, province, country
//          case lastName = "last_name"
//          case address2, company, latitude, longitude, name
//          case countryCode = "country_code"
//          case provinceCode = "province_code"
//          case id
//          case customerID = "customer_id"
//          case countryName = "country_name"
//          case addressDefault = "default"
//      }
//
//}
//
//// MARK: - Customer
//struct Customer: Codable {
//    let id: Int?
//    let email: String?
//    let acceptsMarketing: Bool?
//    let createdAt, updatedAt: String?
//    let firstName, lastName: String?
//    let ordersCount: Int?
//    let state, totalSpent: String?
//    let lastOrderID: Int?
//    let note: String?
//    let verifiedEmail: Bool?
//    let multipassIdentifier: String?
//    let taxExempt: Bool?
//    let tags: String?
//    let lastOrderName: String?
//    let currency: String?
//    let phone: String?
//    let acceptsMarketingUpdatedAt: String?
//    let marketingOptInLevel: String?
//    let taxExemptions: [String?]?
//    let emailMarketingConsent: MarketingConsent?
//    let smsMarketingConsent: MarketingConsent?
//    let adminGraphqlAPIID: String?
//    let defaultAddress: Address?
//
//  enum CodingKeys: String, CodingKey {
//          case id, email
//          case acceptsMarketing = "accepts_marketing"
//          case createdAt = "created_at"
//          case updatedAt = "updated_at"
//          case firstName = "first_name"
//          case lastName = "last_name"
//          case ordersCount = "orders_count"
//          case state
//          case totalSpent = "total_spent"
//          case lastOrderID = "last_order_id"
//          case note
//          case verifiedEmail = "verified_email"
//          case multipassIdentifier = "multipass_identifier"
//          case taxExempt = "tax_exempt"
//          case tags
//          case lastOrderName = "last_order_name"
//          case currency, phone
//          case acceptsMarketingUpdatedAt = "accepts_marketing_updated_at"
//          case marketingOptInLevel = "marketing_opt_in_level"
//          case taxExemptions = "tax_exemptions"
//          case emailMarketingConsent = "email_marketing_consent"
//          case smsMarketingConsent = "sms_marketing_consent"
//          case adminGraphqlAPIID = "admin_graphql_api_id"
//          case defaultAddress = "default_address"
//      }
//
//}
//
//// MARK: - MarketingConsent
//struct MarketingConsent: Codable {
//    let state, optInLevel: String?
//    let consentUpdatedAt: String?
//    let consentCollectedFrom: String?
//
//  enum CodingKeys: String, CodingKey {
//          case state
//          case optInLevel = "opt_in_level"
//          case consentUpdatedAt = "consent_updated_at"
//          case consentCollectedFrom = "consent_collected_from"
//      }
//}
//
//// MARK: - LineItem
//struct LineItem: Codable {
//    let id: Int?
//    let variantID, productID: String?
//    let title: String?
//    let variantTitle, sku, vendor: String?
//    let quantity: Int?
//    let requiresShipping, taxable, giftCard: Bool?
//    let fulfillmentService: String?
//    let grams: Int?
//    let taxLines: [TaxLine]?
//    let appliedDiscount: String?
//    let name: String?
//    let properties: [String?]?
//    let custom: Bool?
//    let price, adminGraphqlAPIID: String?
//
//  enum CodingKeys: String, CodingKey {
//          case id
//          case variantID = "variant_id"
//          case productID = "product_id"
//          case title
//          case variantTitle = "variant_title"
//          case sku, vendor, quantity
//          case requiresShipping = "requires_shipping"
//          case taxable
//          case giftCard = "gift_card"
//          case fulfillmentService = "fulfillment_service"
//          case grams
//          case taxLines = "tax_lines"
//          case appliedDiscount = "applied_discount"
//          case name, properties, custom, price
//          case adminGraphqlAPIID = "admin_graphql_api_id"
//      }
//}
//
//// MARK: - TaxLine
//struct TaxLine: Codable {
//    let rate: Double?
//    let title, price: String?
//}
