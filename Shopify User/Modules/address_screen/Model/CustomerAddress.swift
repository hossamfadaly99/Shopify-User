//
//  CustomerAddress.swift
//  Shopify User
//
//  Created by Hossam on 18/06/2023.
//

import Foundation
struct CustomerAddressResponse: Codable {
    let customerAddress: CustomerAddress?

    enum CodingKeys: String, CodingKey {
        case customerAddress = "customer_address"
    }
}

// MARK: - CustomerAddress
struct CustomerAddress: Codable {
    let id, customerID: Int?
    let firstName, lastName: String?
    let company: String?
    let address1, address2, city, province: String?
    let country: String?
    let zip: String?
    let phone, name, provinceCode, countryCode: String?
    let countryName: String?
    let customerAddressDefault: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case customerID = "customer_id"
        case firstName = "first_name"
        case lastName = "last_name"
        case company, address1, address2, city, province, country, zip, phone, name
        case provinceCode = "province_code"
        case countryCode = "country_code"
        case countryName = "country_name"
        case customerAddressDefault = "default"
    }
}
