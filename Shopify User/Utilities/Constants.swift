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
    static let SCREEN_ID_SEARCH = "ID_Search"
    
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
        static let USER_STATE_LOGOUT = "Logout"
        static let USER_COUPON = "coupon"
        static let CURRENCY_KEY = "CURRENCY_KEY"
        static let CURRENCY_VALUE = "CURRENCY_VALUE"
        
    
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
}
let adminTokenKey = "X-Shopify-Access-Token"
let adminTokenValue = "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"
let dummyMail = "ddd@hhh.com"
let secondDummyMail = "egnition_sample_81@egnition.com"
let BASE_CURRENCY_API = "https://api.apilayer.com/exchangerates_data/latest?base=USD&apikey="
let CURRENCY_API_KEY =  "Qflgr2kG5V3sQQ92JoP8zUe38qGZZlFg"
let CURRENCY_API = BASE_CURRENCY_API + CURRENCY_API_KEY

var currencySymbol: String {
  return UserDefaults.standard.string(forKey: Constants.CURRENCY_KEY) ?? "USD"
}

var currencyValue: Double {
  var value = UserDefaults.standard.double(forKey: Constants.CURRENCY_KEY)
  if value == 0.0 { value = 1.0 }
  return value
}
