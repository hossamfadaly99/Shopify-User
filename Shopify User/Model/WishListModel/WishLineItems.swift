//
//  LineItems.swift
//  Shopify
//
//  Created by Mac on 15/06/2023.
//

import Foundation

struct WishLineItems: Codable {

  var variantId          : Int?      = nil
  var productId          : Int?      = nil
  var title              : String?   = nil
  var variantTitle       : String?   = nil
  var sku                : String?   = nil
  var vendor             : String?   = nil
  var quantity           : Int?      = nil
  var requiresShipping   : Bool?     = nil
  var taxable            : Bool?     = nil
  var giftCard           : Bool?     = nil
  var fulfillmentService : String?   = nil
  var grams              : Int?      = nil
  var taxLines           : [MyTaxLines]? = []
  var appliedDiscount    : String?   = nil
  var name               : String?   = nil
  var properties         : [MyProperties]? = []
  var custom             : Bool?     = nil
  var price              : String?   = nil
  var adminGraphqlApiId  : String?   = nil

  enum CodingKeys: String, CodingKey {

    case variantId          = "variant_id"
    case productId          = "product_id"
    case title              = "title"
    case variantTitle       = "variant_title"
    case sku                = "sku"
    case vendor             = "vendor"
    case quantity           = "quantity"
    case requiresShipping   = "requires_shipping"
    case taxable            = "taxable"
    case giftCard           = "gift_card"
    case fulfillmentService = "fulfillment_service"
    case grams              = "grams"
    case taxLines           = "tax_lines"
    case appliedDiscount    = "applied_discount"
    case name               = "name"
    case properties         = "properties"
    case custom             = "custom"
    case price              = "price"
    case adminGraphqlApiId  = "admin_graphql_api_id"
  
  }

    init(/*varientId:Int,*/title:String,varientTitle:String ,price:String,properties:[MyProperties]){
       // self.variantId = varientId
        self.title = title
        self.variantTitle = varientTitle
        self.price = price
        self.properties = properties
        self.quantity = 1
    }

  init() {

  }

}


struct MyProperties: Codable {

  var name  : String? = nil
  var value : String? = nil
  var color : String? = nil
  var size : String? = nil

  enum CodingKeys: String, CodingKey {

    case name  = "name"
    case value = "value"
  
  }

    init (name:String,value:String){
        
        self.name = name
        self.value = value
    }

  init() {

  }

}
