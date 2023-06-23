//
//  SavedCoupon.swift
//  Shopify User
//
//  Created by Hossam on 23/06/2023.
//

import Foundation
class SavedCoupon: NSObject, NSCoding {
    let code: String
    let value: String
    let type: String

    init(code: String, value: String, type: String) {
        self.code = code
        self.value = value
        self.type = type
    }

    func encode(with coder: NSCoder) {
        coder.encode(code, forKey: "code")
        coder.encode(value, forKey: "value")
        coder.encode(type, forKey: "type")
    }

    required init?(coder: NSCoder) {
        guard let code = coder.decodeObject(forKey: "code") as? String,
              let value = coder.decodeObject(forKey: "value") as? String,
              let type = coder.decodeObject(forKey: "type") as? String else {
            return nil
        }
        self.code = code
        self.value = value
        self.type = type
    }
}
