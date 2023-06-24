//
//  CategoryResponse.swift
//  Shopify User
//
//  Created by Mac on 09/06/2023.
//

import Foundation

// MARK: - CategoryResponse
struct CategoryResponse: Codable {
    let customCollections: [CustomCollection]?

    enum CodingKeys: String, CodingKey {
        case customCollections = "custom_collections"
    }
}

// MARK: - CustomCollection
struct CustomCollection: Codable {
    let id: Int?
    let handle, title: String?
    let updatedAt: String?
    let bodyHTML: String?
    let publishedAt: String?
    let sortOrder: String?
    let templateSuffix: String?
    let publishedScope, adminGraphqlAPIID: String?
    let image: CategoryImage?

    enum CodingKeys: String, CodingKey {
        case id, handle, title
        case updatedAt = "updated_at"
        case bodyHTML = "body_html"
        case publishedAt = "published_at"
        case sortOrder = "sort_order"
        case templateSuffix = "template_suffix"
        case publishedScope = "published_scope"
        case adminGraphqlAPIID = "admin_graphql_api_id"
        case image
    }
}

// MARK: - Image
struct CategoryImage: Codable {
    let createdAt: String?
    let alt: String?
    let width, height: Int?
    let src: String?

    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case alt, width, height, src
    }
}
