//
//  Product.swift
//  Shopify User
//
//  Created by Mac on 04/06/2023.
//

import Foundation

struct ProductCoreData:Codable{
    var id: Int?
    var title: String?
    var rate: Double?
    var price: String?
    var Pimage: String?
    var user_id:String?
}

struct ProductResponse: Codable {
    var products: [Product]?
}

struct Product: Codable {
    var id: Int?
    var title: String?
    var description: String?
    var vendor: String?
    var productType: String?
    var createdAt: String?
    var handle: String?
    var updatedAt: String?
    var publishedAt: String?
    var templateSuffix: String?
    var status: String?
    var publishedScope: String?
    var tags: String?
    var adminGraphqlApiId: String?
    var variants: [ProductVariant]?
    var options: [ProductOption]?
    var images: [ProductImage]?
    var image: ProductImage?
    
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
    var id: Int?
    var productId: Int?
    var title: String?
    var price: String?
    var sku: String?
    var position: Int?
    var inventoryPolicy: String?
    var compareAtPrice: String?
    var fulfillmentService: String?
    var inventoryManagement: String?
    var option1: String?
    var option2: String?
    var option3: String?
    var createdAt: String?
    var updatedAt: String?
    var taxable: Bool?
    var barcode: String?
    var grams: Double?
    var imageId: Int?
    var weight: Double?
    var weightUnit: String?
    var inventoryItemId: Int?
    var inventoryQuantity: Int?
    var oldInventoryQuantity: Int?
    var requiresShipping: Bool?
    var adminGraphqlApiId: String?
    
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
    var id: Int?
    var productId: Int?
    var name: String?
    var position: Int?
    var values: [String]?
    
    private enum CodingKeys: String, CodingKey {
        case id, name, position, values
        case productId = "product_id"
    }
}

struct ProductImage: Codable {
    var id: Int?
    var productId: Int?
    var position: Int?
    var createdAt: String?
    var updatedAt: String?
    var alt: String?
    var width: Int?
    var height: Int?
    var src: String?
    var variantIds: [Int]?
    var adminGraphqlApiId: String?
    
    private enum CodingKeys: String, CodingKey {
        case id, position, alt, width, height, src, variantIds
        case productId = "product_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case adminGraphqlApiId = "admin_graphql_api_id"
    }
}
