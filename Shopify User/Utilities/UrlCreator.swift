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
    //https://mad43-sv-ios3.myshopify.com/admin/api/2023-04/customers/6948853350692/orders.json
    func getAllOrderURL(id: String) -> String{
        endPoint = "/orders"
        print(baseURL + "customers/" + id + endPoint + jsontype)
        return baseURL + "customers/" + "\(storedCustomerId)" + endPoint + jsontype
    }
    func getCreateOrder()->String{
        endPoint = "orders"
        return baseURL + endPoint + jsontype
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
        return baseURL + endPoint + "/" + "\(storedCustomerId)" + jsontype
    }
    func getBrandProducts(brandName:String) -> String{
        //https://mad43-sv-ios3.myshopify.com/admin/api/2023-04/products.json?vendor=ADIDAS
        endPoint = "products"
        return baseURL + endPoint + jsontype + "?vendor=" + brandName
    }
    
    func getAddressURL( addressId: String = "") -> String{
        endPoint = "customers/\(storedCustomerId)/addresses"
        return baseURL + endPoint + jsontype
    }
  func getEditOrDeleteAddressURL( addressId: String = "") -> String{
      endPoint = "customers/\(storedCustomerId)/addresses"
      return baseURL + endPoint + "/\(addressId)" + jsontype
  }
  func setDefaultAddressURL( addressId: String = "") -> String{
      endPoint = "customers/\(storedCustomerId)/addresses"
      return baseURL + endPoint + "/\(addressId)" + "/default" + jsontype
  }
  func getCurrencyURL()-> String{
    return CURRENCY_API
  }
  func getAllPriceRulesURL()->String{
    endPoint = "price_rules"
    return baseURL + endPoint + jsontype
  }

  func getCouponsURL(priceRuleId: String)->String{
    endPoint = "price_rules/\(priceRuleId)/discount_codes"
    return baseURL + endPoint + jsontype
  }
  
}
