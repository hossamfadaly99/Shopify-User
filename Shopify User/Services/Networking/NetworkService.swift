//
//  NetworkService.swift
//  Shopify User
//
//  Created by Hossam on 31/05/2023.
//
import Foundation
import Alamofire

protocol NetworkService{
    func loadData<T: Decodable>(url:String,param :Parameters,header : HTTPHeaders ,compilitionHandler: @escaping (T?, Error?) -> Void)
}
class NetworkCallManager : NetworkService{
  func loadData<T: Decodable>(url:String,param :Parameters,header : HTTPHeaders,compilitionHandler: @escaping (T?, Error?) -> Void){
    AF.request(url,parameters: param,headers: header).responseDecodable(of: T.self){ response in
    //  debugPrint(response)
      
      guard response.data != nil else{
        compilitionHandler(nil , response.error)
        return
      }
      do{
        guard let data = response.data else{
          compilitionHandler(nil , response.error)
          return
        }
        let result = try JSONDecoder().decode(T.self, from: data)
        compilitionHandler(result,nil)
        
      }catch let error{
        print(error.localizedDescription)
        compilitionHandler(nil,error)
      }
    }
  }
}

  class Network {
      
     static let myHeaders : HTTPHeaders = [
        "Content-Type" : "application/json",
        "X-Shopify-Access-Token" : "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" ]
      
     static func createDraftOrder(endPoint: String, model:MyDraftOrders, compilition: @escaping (MyDraftOrder?) -> Void) {
         print("URL: \(endPoint)")
         let myParams: Parameters = [
                            "draft_order": [
                              "note": model.note ,
                                "line_items": [
                                    [
                                        "title": "dummy",
                                        "price": "1000",
                                        "quantity": 1
                                    ]
                                    
                                ],
                                "customer": [
                                  "id": model.customer?.id
                                ],
                                "use_customer_default_address": true
                            ]
                        ]



          AF.request(endPoint, method: .post, parameters: myParams, encoding: JSONEncoding.default, headers: myHeaders).responseData{ response in
              
                  switch response.result {
                      case .success(let data):

                          do {
                                  let jsonData = try JSONDecoder().decode(MyDraftOrder.self, from: data)
                                  debugPrint("In Debug Print",jsonData)
                                  compilition(jsonData)
                            
                          } catch {
                              print("Error: Trying to convert JSON data to string")
                              return
                          }


                      case .failure(let error):
                      print("Errrrrrrr\(error)")
                    
                      compilition(nil)
                  }
              }
          }
      
//      static func postDraftOrder(url:String, model:Draft_orders, handler: @escaping (DraftOrderr?) -> Void) {
//          let myParams: Parameters =
//          [
//              "draft_order": [
//                "note": model.note,
//                  "line_items": [
//                      [
//                          "title": "dummy",
//                          "price": "500",
//                          "quantity": 1
//                      ]
//
//                  ],
//                  "customer": [
//                    "id": model.customer?.id
//                  ],
//                  "use_customer_default_address": true
//              ]
//          ]
//
//        AF.request(url, method: .post, parameters:myParams , encoding: JSONEncoding.default, headers:myHeaders)
//          .validate(statusCode: 200 ..< 299).responseData { response in
//            switch response.result {
//            case .success(let data):
//              do {
//                guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
//                  print("Error: Cannot convert data to JSON object")
//                  return
//                }
//                guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
//                  print("Error: Cannot convert JSON object to Pretty JSON data")
//                  return
//                }
//                guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
//                  print("Error: Could print JSON in String")
//                  return
//                }
//                  print(prettyPrintedJson)
//                  let result = try JSONDecoder().decode(DraftOrderr.self,from: data)
//                  handler(result)
//                  print("saved draft: \(result)")
//              } catch {
//                  handler(nil)
//                  print("Error: Trying to convert JSON data to string")
//                return
//              }
//            case .failure(let error):
//                handler(nil)
//                print(error)
//            }
//          }
//      }
//
    static func postMethod(url:String, model:Customer, handler: @escaping (PostCustomer?) -> Void) {
        let myParams: Parameters =
        [
            "customer": [
                "first_name": model.firstName,
                "last_name" : model.lastName,
                "email": model.email,
                "tags": model.tags
            ]
        ]
      AF.request(url, method: .post, parameters:myParams , encoding: JSONEncoding.default, headers:myHeaders)
        .validate(statusCode: 200 ..< 299).responseData { response in
          switch response.result {
          case .success(let data):
            do {
              guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                print("Error: Cannot convert data to JSON object")
                return
              }
              guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                print("Error: Cannot convert JSON object to Pretty JSON data")
                return
              }
              guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                print("Error: Could print JSON in String")
                return
              }
                print(prettyPrintedJson)
                let result = try JSONDecoder().decode(PostCustomer.self,from: data)
                handler(result)
               // print("saved custumer: \(result)")
            } catch {
                handler(nil)
                print("Error: Trying to convert JSON data to string")
              return
            }
          case .failure(let error):
              handler(nil)
              print(error)
          }
        }
    }
      
    static func updateCustomer(url: String, model:Customer, handler: @escaping (Customer?) -> Void) {
          let myParams: Parameters =
          [
              "customer": [
                "note": model.note
              ]
          ]
          AF.request(url, method: .put, parameters:myParams , encoding: JSONEncoding.default, headers:myHeaders)
            .validate(statusCode: 200 ..< 299).responseData { response in
              switch response.result {
              case .success(let data):
                do {
                  guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                    print("Error: Cannot convert data to JSON object")
                    return
                  }
                  guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                    print("Error: Cannot convert JSON object to Pretty JSON data")
                    return
                  }
                  guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                    print("Error: Could print JSON in String")
                    return
                  }
                    print(prettyPrintedJson)
                    let result = try JSONDecoder().decode(Customer.self,from: data)
                    handler(result)
                   // print("draft custumer: \(result)")
                } catch {
                    handler(nil)
                    print("Error: Trying to convert JSON data to string")
                  return
                }
              case .failure(let error):
                  handler(nil)
                  print("Errror : \(error)")
              }
            }
      }
      
      
//      static func updateDraft<T: Decodable>(url: String, myParams: Parameters, responseType: T.Type, handler: @escaping (T?) -> Void) {
//          AF.request(url, method: .put, parameters: myParams, encoding: JSONEncoding.default, headers: myHeaders)
//              .validate(statusCode: 200 ..< 299).responseData { response in
//                  switch response.result {
//                  case .success(let data):
//                      do {
//                          guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
//                              print("Error: Cannot convert data to JSON object")
//                              handler(nil)
//                              return
//                          }
//                          guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
//                              print("Error: Cannot convert JSON object to Pretty JSON data")
//                              handler(nil)
//                              return
//                          }
//                          guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
//                              print("Error: Could print JSON in String")
//                              handler(nil)
//                              return
//                          }
//                          print(prettyPrintedJson)
//                          let result = try JSONDecoder().decode(T.self, from: data)
//                          handler(result)
//                          print("Result: \(result)")
//                      } catch {
//                          handler(nil)
//                          print("Error: Trying to convert JSON data to string")
//                      }
//                  case .failure(let error):
//                      handler(nil)
//                      print(error)
//                  }
//          }
//      }

      }
