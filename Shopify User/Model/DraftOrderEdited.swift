//
//  DraftOrderEdited.swift
//  Shopify User
//
//  Created by Hossam on 10/06/2023.
//

import Foundation

// MARK: - Welcome
struct DraftOrderEdited: Codable {
    let draftOrder: DraftOrder?

    enum CodingKeys: String, CodingKey {
        case draftOrder = "draft_order"
    }
}

// MARK: - DraftOrder
struct DraftOrder: Codable {
    let id: Int?
    let lineItems: [LineItem]?

    enum CodingKeys: String, CodingKey {
        case id
        case lineItems = "line_items"
    }
}

// MARK: - LineItem
struct LineItem: Codable {
    let variantID, quantity: Int?
    let note: String?
    let properties: [Property]?

    enum CodingKeys: String, CodingKey {
        case variantID = "variant_id"
        case quantity, note, properties
    }
}

// MARK: - Property
struct Property: Codable {
    let name, value: String?
}
