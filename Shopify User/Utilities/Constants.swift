//
//  Constants.swift
//  Shopify User
//
//  Created by Hossam on 31/05/2023.
//

import Foundation

class Constants {
    //Screens IDs
    static let SCREEN_ID_FAVOURITE = "ID_Favourie"
    static let SCREEN_ID_LOGIN = "ID_Login"
    static let SCREEN_ID_SIGNUP = "ID_Signup"
    static let SCREEN_ID_REVIEWS = "ID_Reviews"
    static let SCREEN_ID_PRODUCTSDETAILS = "ID_Products_Details"
    static let SCREEN_ID_HOME = "ID_Home"
    static let SCREEN_ID_BRAND = "ID_Brand"
    static let SCREEN_ID_CATEGORY = "ID_Category"
    static let SCREEN_ID_SEARCH = "ID_Search"
    static let SCREEN_ID_PROFILE = "ID_Profile"
    
    //Cell IDs
    static let CELL_ID_FAVOURITE = "Fav_Cell"
    static let CELL_ID_PODUCT_DETAILS = "Prouduct_Details_cell"
    
    //User Defults
        static let KEY_USER_FIRSTNAME = "UserFirstName"
        static let KEY_USER_LASTNAME = "UserLastName"
        static let KEY_USER_EMAIL = "UserEmail"
        static let USER_WISHLIST = "WishList"
        static let USER_CART = "Cart"
        static let KEY_USER_ID = "UserID"
        static let KEY_USER_STATE = "State"
        static let USER_STATE_LOGIN = "Login"
        static let USER_STATE_GUEST = "Guest"
        static let USER_STATE_LOGOUT = "Logout"
        static let USER_COUPON = "coupon"
        static let CURRENCY_KEY = "CURRENCY_KEY"
        static let CURRENCY_VALUE = "CURRENCY_VALUE"
        static let COUPON_VALUE_OBJECT = "COUPON_VALUE_OBJECT"
        static let COUPON_VALUE_TYPE_OBJECT = "COUPON_VALUE_TYPE_OBJECT"
        static let COUPON_NAME_OBJECT = "COUPON_NAME_OBJECT"
        static let COUPON_OBJECT = "COUPON_OBJECT"

        
    
    //Search
    static let HOME_SEARCH_ICON = "homeSearchIcon"

    //CoreData
    static let CD_ENTITY_NAME = "CDProduct"
    static let ENTITY_ROW_TITLE = "title"
    static let ENTITY_ROW_ID = "id"
    static let ENTITY_ROW_USER_ID = "user_id"
    static let ENTITY_ROW_IMAGE = "imageProduct"
    static let ENTITY_ROW_PRICE = "price"
    static let ENTITY_ROW_RATE = "rate"
    
    func mapProductToLineItems(product : Product) ->Line_items{
        var property = Properties(name: "img_url", value: product.image?.src)
        var result = Line_items()
        result.title = product.title
        result.price = product.variants?[0].price
        result.properties = [property]
        result.quantity = 1
        result.variant_id = product.variants?[0].id
        result.name = product.title
        result.grams = 0
        result.taxable = true
        result.gift_card = false
        result.custom = true
        return result
    }
    func mapProductToProductCD(product : Product) ->ProductCoreData{
        guard  let customer_id = UserDefaults.standard.string(forKey: Constants.KEY_USER_ID) else {return ProductCoreData()}
        var result = ProductCoreData(id: product.id,title: product.title,price: product.variants?[0].price,Pimage: product.image?.src,user_id: customer_id)
        return result
    }
    func mapLineItemsToProductCD( lineitems : [Line_items] ) -> [ProductCoreData] {
        guard  let customer_id = UserDefaults.standard.string(forKey: Constants.KEY_USER_ID) else {return []}
        var productCDArray: [ProductCoreData] = []
           
           for lineItem in lineitems {
               if(lineItem.title == "dummy"){
                   print("MYDummy")
               }
               else{
                   let name = lineItem.properties?[0].value
                   print("immmmmmmage\(name)")
                   var productCD = ProductCoreData()
                   productCD.title = lineItem.title
                   productCD.id = lineItem.id
                   productCD.price = lineItem.price
                   productCD.Pimage = lineItem.properties?[0].value
                   productCD.user_id = customer_id
                   
                   // Add any additional properties you need to set on `productCD`
                   
                   productCDArray.append(productCD)}
           }
           return productCDArray
    }
}
let adminTokenKey = "X-Shopify-Access-Token"
let adminTokenValue = "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"
let dummyMail = "ddd@hhh.com"
let secondDummyMail = "egnition_sample_81@egnition.com"
let BASE_CURRENCY_API = "https://api.apilayer.com/exchangerates_data/latest?base=USD&apikey="
let CURRENCY_API_KEY =  "Qflgr2kG5V3sQQ92JoP8zUe38qGZZlFg"
let CURRENCY_API = BASE_CURRENCY_API + CURRENCY_API_KEY
let emptyProductId = 46789

var currencySymbol: String {
  return UserDefaults.standard.string(forKey: Constants.CURRENCY_KEY) ?? "USD"
}
var cartId: Int {
  return Int(UserDefaults.standard.string(forKey: Constants.USER_CART) ?? "") ?? 0
}
var favvvId: Int {
  return Int(UserDefaults.standard.string(forKey: Constants.USER_WISHLIST) ?? "") ?? 0
}

var storedCustomerId: Int {
  return Int(UserDefaults.standard.string(forKey: Constants.KEY_USER_ID) ?? "" ) ?? 0
}

var currencyValue: Double {
  var value = UserDefaults.standard.double(forKey: Constants.CURRENCY_VALUE)
//  print("liwurhgiuohlitg1111")
//  print(value)
  if value == 0.0 { value = 1.0 }
  return value
}

func isValidMobileNumber(_ mobileNumber: String) -> Bool {
    let mobileNumberRegex = "^\\d{11}$"
    let mobileNumberPredicate = NSPredicate(format: "SELF MATCHES %@", mobileNumberRegex)
    return mobileNumberPredicate.evaluate(with: mobileNumber)
}
