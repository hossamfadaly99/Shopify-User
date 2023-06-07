//
//  NetworkService.swift
//  Shopify User
//
//  Created by Hossam on 31/05/2023.
//

import Foundation
import Alamofire

class Network {
    
//    static func postMethod(url:String, model:Customer) {
//
//        let myHeaders : HTTPHeaders = [
//           "Content-Type" : "application/json",
//           "X-Shopify-Access-Token" : "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"
//       ]
//        AF.request(url, method: .post, parameters: model, encoding: JSONEncoding.default, headers:myHeaders)
//            .validate(statusCode: 200 ..< 299).responseData { response in
//            switch response.result {
//                case .success(let data):
//                    do {
//                        guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
//                            print("Error: Cannot convert data to JSON object")
//                            return
//                        }
//                        guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
//                            print("Error: Cannot convert JSON object to Pretty JSON data")
//                            return
//                        }
//                        guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
//                            print("Error: Could print JSON in String")
//                            return
//                        }
//
//                        print(prettyPrintedJson)
//
//                        let result = try JSONDecoder().decode(Customer.self,from: data)
//                        print("saved custumer: \(result)")
//
//                    } catch {
//                        print("Error: Trying to convert JSON data to string")
//                        return
//                    }
//                case .failure(let error):
//                print(error)
//            }
//        }
//    }
//
    
    static func postMethod(url: String, model: Customer) {
        let myHeaders: HTTPHeaders = [
            "Content-Type": "application/json",
            "X-Shopify-Access-Token": "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"
        ]

        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(model)
            let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any]
            
            AF.request(url, method: .post, parameters: jsonObject, encoding: JSONEncoding.default, headers: myHeaders)
                .validate(statusCode: 200..<300)
                .response { response in
                    switch response.result {
                    case .success(let data):
                        if let data = data {
                            do {
                                let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any]
                                let prettyJsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
                                if let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) {
                                    print(prettyPrintedJson)
                                }
                                
                                let result = try JSONDecoder().decode(Customer.self, from: data)
                                print("Saved customer: \(result)")
                            } catch {
                                print("Error: Failed to decode JSON data - \(error)")
                            }
                        } else {
                            print("Error: Empty response data")
                        }
                    case .failure(let error):
                        print("Error: \(error)")
                    }
                }
        } catch {
            print("Error: Failed to encode Customer object - \(error)")
        }
    }

}
