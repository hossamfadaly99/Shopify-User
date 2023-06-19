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
    func getCustomer(customer_id : String) -> String {
        //https://mad43-sv-ios3.myshopify.com/admin/api/2023-04/customers/6954207117604.json
        endPoint = "customers"
        return baseURL + endPoint + "/" + customer_id + jsontype
    }
    func getBrandProducts(brandName:String) -> String{
        //https://mad43-sv-ios3.myshopify.com/admin/api/2023-04/products.json?vendor=ADIDAS
        endPoint = "products"
        return baseURL + endPoint + jsontype + "?vendor=" + brandName
    }
    
    func getAddressURL(customerId: String, addressId: String = "") -> String{
        endPoint = "customers/\(customerId)/addresses"
        return baseURL + endPoint + jsontype + "/\(addressId)"
    }
  func getCurrencyURL()-> String{
    return CURRENCY_API
  }
}
