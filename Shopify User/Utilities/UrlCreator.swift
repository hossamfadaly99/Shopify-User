//
//  UrlCreator.swift
//  Shopify User
//
//  Created by Hossam on 08/06/2023.
//

import Foundation
class URLCreator {
    private let baseURL = "https://mad43-sv-ios3.myshopify.com/admin/api/2023-04/"
    private var endPoint = ""
    private var jsontype = ".json"
    
    func getEditCartURL(id: String) -> String{
        endPoint = "draft_orders/"
        return baseURL + endPoint + id + jsontype
    }
    
    func getCreateCartURL() -> String{
        endPoint = "draft_orders"
        return baseURL + endPoint + jsontype
    }
    func getProductsURL()->String{
        endPoint = "products"
        return baseURL + endPoint + jsontype
    }
    func getProductURL(id : String)->String{
        //https://mad43-sv-ios3.myshopify.com/admin/api/2023-04/products.json?ids=8355419586852
        endPoint = "products"
        return baseURL + endPoint + jsontype + "?ids=" + id
    }
    func getCustomersURL() -> String{
        //https://mad43-sv-ios3.myshopify.com/admin/api/2023-04/customers.json
        endPoint = "customers"
        return baseURL + endPoint + jsontype
    }
    func getBrandProducts(brandName:String) -> String{
        //https://mad43-sv-ios3.myshopify.com/admin/api/2023-04/products.json?vendor=ADIDAS
        endPoint = "products"
        return baseURL + endPoint + jsontype + "?vendor=" + brandName
    }
}
