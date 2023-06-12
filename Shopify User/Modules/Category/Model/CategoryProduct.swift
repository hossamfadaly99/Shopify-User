//
//  CategoryProduct.swift
//  Shopify User
//
//  Created by Mac on 09/06/2023.
//

import Foundation

// MARK: - CategoryProduct
struct CategoryProductResponse: Codable {
    let products: [CategoryProduct]?
}

// MARK: - Product
struct CategoryProduct: Codable {
    let id: Int?
    let title, bodyHTML, vendor, productType: String?
    let createdAt: String?
    let handle: String?
    let updatedAt, publishedAt: String?
    let templateSuffix: String?
    let status, publishedScope, tags, adminGraphqlAPIID: String?
    let options: [Option]?
    let images: [CategoryProductImage]?
    let image: CategoryProductImage?

    enum CodingKeys: String, CodingKey {
        case id, title
        case bodyHTML = "body_html"
        case vendor
        case productType = "product_type"
        case createdAt = "created_at"
        case handle
        case updatedAt = "updated_at"
        case publishedAt = "published_at"
        case templateSuffix = "template_suffix"
        case status
        case publishedScope = "published_scope"
        case tags
        case adminGraphqlAPIID = "admin_graphql_api_id"
        case options, images, image
    }
}

// MARK: - Image
struct CategoryProductImage: Codable {
    let id, productID, position: Int?
    let createdAt, updatedAt: String?
    let alt: String?
    let width, height: Int?
    let src: String?
    let variantIDS: [Int]?
    let adminGraphqlAPIID: String?

    enum CodingKeys: String, CodingKey {
        case id
        case productID = "product_id"
        case position
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case alt, width, height, src
        case variantIDS = "variant_ids"
        case adminGraphqlAPIID = "admin_graphql_api_id"
    }
}

// MARK: - Option
struct Option: Codable {
    let id, productID: Int?
    let name: String?
    let position: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case productID = "product_id"
        case name, position
    }
}
