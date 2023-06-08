//
//  Customer.swift
//  Shopify User
//
//  Created by MAC on 04/06/2023.
//

import Foundation

struct RootCustomer: Codable{
    var customers: [Customer]
}

struct Customer: Codable {
    var id: Int?
    var email: String?
    var acceptsMarketing: Bool?
    var createdAt: String?
    var updatedAt: String?
    var firstName: String?
    var lastName: String?
    var ordersCount: Int?
    var state: String?
    var totalSpent: String?
    var lastOrderId: String?
    var note: String?
    var verifiedEmail: Bool?
    var multipassIdentifier: String?
    var taxExempt: Bool?
    var tags: String?
    var lastOrderName: String?
    var currency: String?
    var phone: String?
    var addresses: [Address]?
    var acceptsMarketingUpdatedAt: String?
    var marketingOptInLevel: String?
    var taxExemptions: [String]?
    var emailMarketingConsent: EmailMarketingConsent?
    var smsMarketingConsent: String?
    var adminGraphqlApiId: String?
    var defaultAddress: DefaultAddress?
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case acceptsMarketing = "accepts_marketing"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case firstName = "first_name"
        case lastName = "last_name"
        case ordersCount = "orders_count"
        case state
        case totalSpent = "total_spent"
        case lastOrderId = "last_order_id"
        case note
        case verifiedEmail = "verified_email"
        case multipassIdentifier = "multipass_identifier"
        case taxExempt = "tax_exempt"
        case tags
        case lastOrderName = "last_order_name"
        case currency
        case phone
        case addresses
        case acceptsMarketingUpdatedAt = "accepts_marketing_updated_at"
        case marketingOptInLevel = "marketing_opt_in_level"
        case taxExemptions = "tax_exemptions"
        case emailMarketingConsent = "email_marketing_consent"
        case smsMarketingConsent = "sms_marketing_consent"
        case adminGraphqlApiId = "admin_graphql_api_id"
        case defaultAddress = "default_address"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        email = try container.decodeIfPresent(String.self, forKey: .email)
        acceptsMarketing = try container.decodeIfPresent(Bool.self, forKey: .acceptsMarketing)
        createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try container.decodeIfPresent(String.self, forKey: .updatedAt)
        firstName = try container.decodeIfPresent(String.self, forKey: .firstName)
        lastName = try container.decodeIfPresent(String.self, forKey: .lastName)
        ordersCount = try container.decodeIfPresent(Int.self, forKey: .ordersCount)
        state = try container.decodeIfPresent(String.self, forKey: .state)
        totalSpent = try container.decodeIfPresent(String.self, forKey: .totalSpent)
        lastOrderId = try container.decodeIfPresent(String.self, forKey: .lastOrderId)
        note = try container.decodeIfPresent(String.self, forKey: .note)
        verifiedEmail = try container.decodeIfPresent(Bool.self, forKey: .verifiedEmail)
        multipassIdentifier = try container.decodeIfPresent(String.self, forKey: .multipassIdentifier)
        taxExempt = try container.decodeIfPresent(Bool.self, forKey: .taxExempt)
        tags = try container.decodeIfPresent(String.self, forKey: .tags)
        lastOrderName = try container.decodeIfPresent(String.self, forKey: .lastOrderName)
        currency = try container.decodeIfPresent(String.self, forKey: .currency)
        phone = try container.decodeIfPresent(String.self, forKey: .phone)
        addresses = try container.decodeIfPresent([Address].self, forKey: .addresses)
        acceptsMarketingUpdatedAt = try container.decodeIfPresent(String.self, forKey: .acceptsMarketingUpdatedAt)
        marketingOptInLevel = try container.decodeIfPresent(String.self, forKey: .marketingOptInLevel)
        taxExemptions = try container.decodeIfPresent([String].self, forKey: .taxExemptions)
        emailMarketingConsent = try container.decodeIfPresent(EmailMarketingConsent.self, forKey: .emailMarketingConsent)
        smsMarketingConsent = try container.decodeIfPresent(String.self, forKey: .smsMarketingConsent)
        adminGraphqlApiId = try container.decodeIfPresent(String.self, forKey: .adminGraphqlApiId)
        defaultAddress = try container.decodeIfPresent(DefaultAddress.self, forKey: .defaultAddress)
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
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        id           = try values.decodeIfPresent(Int.self    , forKey: .id           )
        customerId   = try values.decodeIfPresent(Int.self    , forKey: .customerId   )
        firstName    = try values.decodeIfPresent(String.self , forKey: .firstName    )
        lastName     = try values.decodeIfPresent(String.self , forKey: .lastName     )
        company      = try values.decodeIfPresent(String.self , forKey: .company      )
        address1     = try values.decodeIfPresent(String.self , forKey: .address1     )
        address2     = try values.decodeIfPresent(String.self , forKey: .address2     )
        city         = try values.decodeIfPresent(String.self , forKey: .city         )
        province     = try values.decodeIfPresent(String.self , forKey: .province     )
        country      = try values.decodeIfPresent(String.self , forKey: .country      )
        zip          = try values.decodeIfPresent(String.self , forKey: .zip          )
        phone        = try values.decodeIfPresent(String.self , forKey: .phone        )
        name         = try values.decodeIfPresent(String.self , forKey: .name         )
        provinceCode = try values.decodeIfPresent(String.self , forKey: .provinceCode )
        countryCode  = try values.decodeIfPresent(String.self , forKey: .countryCode  )
        countryName  = try values.decodeIfPresent(String.self , forKey: .countryName  )
        isDefault      = try values.decodeIfPresent(Bool.self   , forKey: .isDefault      )
     
      }
    init(){}

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
    init(){}
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
    init(){}
}
