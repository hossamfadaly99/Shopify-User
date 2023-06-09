//
//  Product.swift
//  Shopify User
//
//  Created by Mac on 04/06/2023.
//

import Foundation

struct ProductResponse: Codable {
    var products: [Product]?
}

struct Product: Codable {
    let id: Int?
    let title: String?
    let description: String?
    let vendor: String?
    let productType: String?
    let createdAt: String?
    let handle: String?
    let updatedAt: String?
    let publishedAt: String?
    let templateSuffix: String?
    let status: String?
    let publishedScope: String?
    let tags: String?
    let adminGraphqlApiId: String?
    let variants: [ProductVariant]?
    let options: [ProductOption]?
    let images: [ProductImage]?
    let image: ProductImage?
    
    private enum CodingKeys: String, CodingKey {
        case id, title, vendor, tags, variants, options, images, image
        case description = "body_html"
        case productType = "product_type"
        case createdAt = "created_at"
        case handle, updatedAt = "updated_at", publishedAt = "published_at"
        case templateSuffix = "template_suffix", status, publishedScope = "published_scope"
        case adminGraphqlApiId = "admin_graphql_api_id"
    }
}

struct ProductVariant: Codable {
    let id: Int?
    let productId: Int?
    let title: String?
    let price: String?
    let sku: String?
    let position: Int?
    let inventoryPolicy: String?
    let compareAtPrice: String?
    let fulfillmentService: String?
    let inventoryManagement: String?
    let option1: String?
    let option2: String?
    let option3: String?
    let createdAt: String?
    let updatedAt: String?
    let taxable: Bool?
    let barcode: String?
    let grams: Double?
    let imageId: Int?
    let weight: Double?
    let weightUnit: String?
    let inventoryItemId: Int?
    let inventoryQuantity: Int?
    let oldInventoryQuantity: Int?
    let requiresShipping: Bool?
    let adminGraphqlApiId: String?
    
    private enum CodingKeys: String, CodingKey {
        case id, title, price, sku, position, taxable, barcode, grams, weight, imageId, weightUnit
        case productId = "product_id"
        case inventoryPolicy = "inventory_policy"
        case compareAtPrice = "compare_at_price"
        case fulfillmentService = "fulfillment_service"
        case inventoryManagement = "inventory_management"
        case option1, option2, option3, createdAt = "created_at"
        case updatedAt = "updated_at"
        case inventoryItemId = "inventory_item_id"
        case inventoryQuantity = "inventory_quantity"
        case oldInventoryQuantity = "old_inventory_quantity"
        case requiresShipping = "requires_shipping"
        case adminGraphqlApiId = "admin_graphql_api_id"
    }
}

struct ProductOption: Codable {
    let id: Int?
    let productId: Int?
    let name: String?
    let position: Int?
    let values: [String]?
    
    private enum CodingKeys: String, CodingKey {
        case id, name, position, values
        case productId = "product_id"
    }
}

struct ProductImage: Codable {
    let id: Int?
    let productId: Int?
    let position: Int?
    let createdAt: String?
    let updatedAt: String?
    let alt: String?
    let width: Int?
    let height: Int?
    let src: String?
    let variantIds: [Int]?
    let adminGraphqlApiId: String?
    
    private enum CodingKeys: String, CodingKey {
        case id, position, alt, width, height, src, variantIds
        case productId = "product_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case adminGraphqlApiId = "admin_graphql_api_id"
    }
}
