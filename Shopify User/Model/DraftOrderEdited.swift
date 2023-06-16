//
//  DraftOrderEdited.swift
//  Shopify User
//
//  Created by Hossam on 10/06/2023.
//

import Foundation

// MARK: - Welcome
struct DraftOrderEdited: Codable {
    var draftOrder: DraftOrder?

    enum CodingKeys: String, CodingKey {
        case draftOrder = "draft_order"
    }
}

// MARK: - DraftOrder
struct DraftOrder: Codable {
//    let id: Int?
  var lineItems: [LineItem] = []

    enum CodingKeys: String, CodingKey {
//        case id
        case lineItems = "line_items"
    }
}

// MARK: - LineItem
struct LineItem: Codable {
  var variantID : Int?
  var title: String? = ""
  var price: Double?
  var quantity: Int?
  var properties: [Property] = []

    enum CodingKeys: String, CodingKey {
        case variantID = "variant_id"
        case quantity, properties, title
    }
}

// MARK: - Property
struct Property: Codable {
  var name, value: String?
}
