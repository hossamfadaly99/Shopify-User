////
////  Customer.swift
////  Shopify User
////
////  Created by MAC on 04/06/2023.
////
//
import Foundation


//struct MyCustomer:Codable{
//
//    var customers:[Customer]
//
//}
//
//
//
//struct Customer:Codable {
//
//    var id:Int?
//
//    var first_name:String?
//
//    var last_name:String?
//
//    var email:String?
//
//    var tags:String?
//
//}

struct RootCustomer: Codable{
    var customers : [Customer]? = []
     enum CodingKeys: String, CodingKey {
       case customers
     }
    init(from decoder: Decoder) throws {
      let values = try decoder.container(keyedBy: CodingKeys.self)

        customers = try values.decodeIfPresent([Customer].self , forKey: .customers )
   
    }

    init() {

    }

}
struct PostCustomer: Codable{
    var customer : Customer?
     enum CodingKeys: String, CodingKey {
       case customer
     }
}

struct Customer: Codable {
  var id                        : Int?                   = nil
  var email                     : String?                = nil
  var acceptsMarketing          : Bool?                  = nil
  var createdAt                 : String?                = nil
  var updatedAt                 : String?                = nil
  var firstName                 : String?                = nil
  var lastName                  : String?                = nil
  var ordersCount               : Int?                   = nil
  var state                     : String?                = nil
  var totalSpent                : String?                = nil
  var note                      : String?                = nil
  var verifiedEmail             : Bool?                  = nil
  var multipassIdentifier       : String?                = nil
  var taxExempt                 : Bool?                  = nil
  var tags                      : String?                = nil
  var currency                  : String?                = nil
  var phone                     : String?                = nil
  var addresses                 : [Address]?              = []
//  var acceptsMarketingUpdatedAt : String?                = nil
//  var marketingOptInLevel       : String?                = nil
//  var taxExemptions             : [String]?              = []
//  var emailMarketingConsent     : EmailMarketingConsent? = EmailMarketingConsent()
 // var smsMarketingConsent       : String?                = nil
//  var adminGraphqlApiId         : String?                = nil

  enum CodingKeys: String, CodingKey {

    case id                        = "id"
    case email                     = "email"
    case acceptsMarketing          = "accepts_marketing"
    case createdAt                 = "created_at"
    case updatedAt                 = "updated_at"
    case firstName                 = "first_name"
    case lastName                  = "last_name"
    case ordersCount               = "orders_count"
    case state                     = "state"
    case totalSpent                = "total_spent"
    case note                      = "note"
    case verifiedEmail             = "verified_email"
    case multipassIdentifier       = "multipass_identifier"
    case taxExempt                 = "tax_exempt"
    case tags                      = "tags"
    case currency                  = "currency"
    case phone                     = "phone"
    case addresses                 = "addresses"
//    case acceptsMarketingUpdatedAt = "accepts_marketing_updated_at"
//    case marketingOptInLevel       = "marketing_opt_in_level"
//    case taxExemptions             = "tax_exemptions"
    //case emailMarketingConsent     = "email_marketing_consent"
    //case smsMarketingConsent       = "sms_marketing_consent"
  //  case adminGraphqlApiId         = "admin_graphql_api_id"

  }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        id                        = try values.decodeIfPresent(Int.self                   , forKey: .id                        )
        email                     = try values.decodeIfPresent(String.self                , forKey: .email                     )
        acceptsMarketing          = try values.decodeIfPresent(Bool.self                  , forKey: .acceptsMarketing          )
        createdAt                 = try values.decodeIfPresent(String.self                , forKey: .createdAt                 )
        updatedAt                 = try values.decodeIfPresent(String.self                , forKey: .updatedAt                 )
        firstName                 = try values.decodeIfPresent(String.self                , forKey: .firstName                 )
        lastName                  = try values.decodeIfPresent(String.self                , forKey: .lastName                  )
        ordersCount               = try values.decodeIfPresent(Int.self                   , forKey: .ordersCount               )
        state                     = try values.decodeIfPresent(String.self                , forKey: .state                     )
        totalSpent                = try values.decodeIfPresent(String.self                , forKey: .totalSpent                )
        note                      = try values.decodeIfPresent(String.self                , forKey: .note                      )
        verifiedEmail             = try values.decodeIfPresent(Bool.self                  , forKey: .verifiedEmail             )
        multipassIdentifier       = try values.decodeIfPresent(String.self                , forKey: .multipassIdentifier       )
        taxExempt                 = try values.decodeIfPresent(Bool.self                  , forKey: .taxExempt                 )
        tags                      = try values.decodeIfPresent(String.self                , forKey: .tags                      )
        currency                  = try values.decodeIfPresent(String.self                , forKey: .currency                  )
        phone                     = try values.decodeIfPresent(String.self                , forKey: .phone                     )
        addresses                 = try values.decodeIfPresent([Address].self              , forKey: .addresses                 )
     
      }

      init() {

      }


 }
struct Address : Codable {
      var id           : Int?    = nil
      var customerId   : Int?    = nil
      var firstName    : String? = nil
      var lastName     : String? = nil
      var company      : String? = nil
      var address1     : String? = nil
      var address2     : String? = nil
      var city         : String? = nil
      var province     : String? = nil
      var country      : String? = nil
      var zip          : String? = nil
      var phone        : String? = nil
      var name         : String? = nil
      var provinceCode : String? = nil
      var countryCode  : String? = nil
      var countryName  : String? = nil
      var isDefault      : Bool?   = nil

      enum CodingKeys: String, CodingKey {

        case id           = "id"
        case customerId   = "customer_id"
        case firstName    = "first_name"
        case lastName     = "last_name"
        case company      = "company"
        case address1     = "address1"
        case address2     = "address2"
        case city         = "city"
        case province     = "province"
        case country      = "country"
        case zip          = "zip"
        case phone        = "phone"
        case name         = "name"
        case provinceCode = "province_code"
        case countryCode  = "country_code"
        case countryName  = "country_name"
        case isDefault      = "default"

      }
    
}

struct EmailMarketingConsent: Codable {

    var state            : String? = nil
    var optInLevel       : String? = nil
    var consentUpdatedAt : String? = nil

    enum CodingKeys: String, CodingKey {

        case state            = "state"
        case optInLevel       = "opt_in_level"
        case consentUpdatedAt = "consent_updated_at"

    }
}

struct DefaultAddress: Codable {

    var id           : Int?    = nil
    var customerId   : Int?    = nil
    var firstName    : String? = nil
    var lastName     : String? = nil
    var company      : String? = nil
    var address1     : String? = nil
    var address2     : String? = nil
    var city         : String? = nil
    var province     : String? = nil
    var country      : String? = nil
    var zip          : String? = nil
    var phone        : String? = nil
    var name         : String? = nil
    var provinceCode : String? = nil
    var countryCode  : String? = nil
    var countryName  : String? = nil
    var isDefault      : Bool?   = nil

    enum CodingKeys: String, CodingKey {

        case id           = "id"
        case customerId   = "customer_id"
        case firstName    = "first_name"
        case lastName     = "last_name"
        case company      = "company"
        case address1     = "address1"
        case address2     = "address2"
        case city         = "city"
        case province     = "province"
        case country      = "country"
        case zip          = "zip"
        case phone        = "phone"
        case name         = "name"
        case provinceCode = "province_code"
        case countryCode  = "country_code"
        case countryName  = "country_name"
        case isDefault      = "default"

    }
}
