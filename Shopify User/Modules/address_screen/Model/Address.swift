//
//  Address.swift
//  Shopify User
//
//  Created by Hossam on 17/06/2023.
//

import Foundation

// MARK: - Welcome
struct Addresses: Codable {
    var addresses: [Address_]?
}

struct AddressRequest: Codable {
    var address: Address_?
}

// MARK: - Address
struct Address_: Codable {
    var id, customerID: Int?
    var firstName, lastName: String?
    var company: String?
    var address1, address2, city, province: String?
    var country: String?
    var zip: String?
    var phone, name, provinceCode, countryCode: String?
    var countryName: String?
    var addressDefault: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case customerID = "customer_id"
        case firstName = "first_name"
        case lastName = "last_name"
        case company, address1, address2, city, province, country, zip, phone, name
        case provinceCode = "province_code"
        case countryCode = "country_code"
        case countryName = "country_name"
        case addressDefault = "default"
    }
}

