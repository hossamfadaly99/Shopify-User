//
//  Home.swift
//  Shopify User
//
//  Created by Hossam on 31/05/2023.
//

import Foundation

// MARK: - Response
struct Response: Codable {
    var smart_collections: [SmartCollection]?
}

// MARK: - SmartCollection
struct SmartCollection: Codable {
    var id: Int?
    var handle, title: String?
    var updatedAt: String?
    var bodyHTML: String?
    var publishedAt: String?
    var sortOrder: String?
    var templateSuffix: String?
    var disjunctive: Bool?
    var rules: [Rule]?
    var publishedScope: String?
    var adminGraphqlAPIID: String?
    var image: Image?

    enum CodingKeys: String, CodingKey {
        case id, handle, title
        case updatedAt = "updated_at"
        case bodyHTML = "body_html"
        case publishedAt = "published_at"
        case sortOrder = "sort_order"
        case templateSuffix = "template_suffix"
        case disjunctive, rules
        case publishedScope = "published_scope"
        case adminGraphqlAPIID = "admin_graphql_api_id"
        case image
    }
}

// MARK: - Image
struct Image: Codable {
    var createdAt: String?
    var alt: String?
    var width, height: Int?
    var src: String?

    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case alt, width, height, src
    }
}

// MARK: - Rule
struct Rule: Codable {
    var column: String?
    var relation: String?
    var condition: String?
}
