//
//  NetworkManager.swift
//  Shopify User
//
//  Created by Hossam on 08/06/2023.
//

import Foundation
import Alamofire

class NetworkManager: NetworkServiceProtocol {

  private var url: URL!

  init(url: String!) {
    self.url = URL(string: url)
  }

  func setURL(_ url: String) {
    self.url = URL(string: url)
  }

  func fetchData<T>(compilitionHandler: @escaping (T?) -> Void) where T : Codable {
    guard let finalURL = url else {
      print("url error")
      return
    }

    let headers: HTTPHeaders = [adminTokenKey : adminTokenValue,
                                "Content-Type" : "application/json"]

    AF.request(finalURL, headers: headers).responseData{ response in
      switch response.result {
      case .success(let data):
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
          let prettyJsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                  let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8)!

          print("jenvkbektbvk1")
          print(prettyPrintedJson)
          print("jenvkbektbvk")

          print(json)
        } catch {
            print("errorMsg")
        }
          do {
              print("The count of data is : \(data.count)")

              let result = try JSONDecoder().decode(T.self, from: data)
            print(result)
            print("liruhgiurtiuniutnbiutdyiobno \(T.self)")

              compilitionHandler(result)
              print("Data Fetched Successfully...")
          } catch {
              print("fetch func Error When Parseing data from API :  \(error.localizedDescription)")
              print(String(describing: error))

              compilitionHandler(nil)
          }
      case .failure(let error):
          print("Error When Featch data from API :  \(error.localizedDescription)")
          compilitionHandler(nil)
      }
    }

  }
//    
//    func customerfetchData(compilitionHandler: @escaping (RootCustomer?) -> Void)  {
//      guard let finalURL = url else {
//        print("url error")
//        return
//      }
//
//      let headers: HTTPHeaders = [adminTokenKey : adminTokenValue,
//                                  "Content-Type" : "application/json"]
//
//      AF.request(finalURL, headers: headers).responseData{ response in
//        switch response.result {
//        case .success(let data):
//          do {
//              let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
//           // print(json)
//          } catch {
//              print("errorMsg")
//          }
//            do {
//                print("The count of data is : \(data.count)")
//
//                let result = try JSONDecoder().decode(RootCustomer.self, from: data)
//
//                compilitionHandler(result)
//                print("Data Fetched Successfully...")
//            } catch {
//                print("fetch func Error When Parseing data from API :  \(error.localizedDescription)")
//                print(String(describing: error))
//
//                compilitionHandler(nil)
//            }
//        case .failure(let error):
//            print("Error When Featch data from API :  \(error.localizedDescription)")
//            compilitionHandler(nil)
//        }
//      }
//
//    }

  func uploadData<G: Codable, T: Codable>(object: G, method: HTTPMethod, compilitionHandler: @escaping (T?) -> Void) {
      print("entered")
    guard let finalURL = url else {
      print("url error")
      return
    }

      let headers: HTTPHeaders = [adminTokenKey : adminTokenValue,
                                  "Content-Type" : "application/json"]

    print(method)
    AF.request(finalURL, method: method, parameters: object, encoder: JSONParameterEncoder.default, headers: headers).responseData{ response in
      switch response.result {
      case .success(let data):
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
          let prettyJsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                  let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8)!

          print(prettyPrintedJson)
//          print(method)
          print("jenvkbektbvkmonica")
          print("kjkjkjjkjkkjkjkjkjkjkjkj")
          print(json)
        } catch {
            print("errorMsg")
        }
          do {
              print("The count of data is : \(data.count)")

              let result = try JSONDecoder().decode(T.self, from: data)


              compilitionHandler(result)
              print("Data Fetched Successfully...")
          } catch {
              print("error When Parseing data from API :  \(error.localizedDescription)")
              print(String(describing: error))

              compilitionHandler(nil)
          }
      case .failure(let error):
          print("Error When Featch data from API :  \(error.localizedDescription)")
          compilitionHandler(nil)
      }
    }

  }

  func updateData<G: Codable, T: Codable>(object: G, method: HTTPMethod, compilitionHandler: @escaping (T?) -> Void) {
    guard let finalURL = url else {
      print("url error")
      return
    }

    print("this is update")
    let headers: HTTPHeaders = [adminTokenKey : adminTokenValue,
                                "Content-Type" : "application/json"]

    print(method)
    AF.request(finalURL, method: .put, parameters: object, encoder: JSONParameterEncoder.default, headers: headers).responseData{ response in
      switch response.result {
      case .success(let data):
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
          let prettyJsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                  let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8)!

          print(prettyPrintedJson)
//          print(method)
          print("jenvkbektbvk")
          print("kjkjkjjkjkkjkjkjkjkjkjkj")
          print(json)
        } catch {
            print("errorMsg")
          print("error When Parseing data from API :  \(error.localizedDescription)")
          print(String(describing: error))
          print("wwwwwwwwww")
        }
          do {
              print("The count of data is : \(data.count)")

              let result = try JSONDecoder().decode(T.self, from: data)


              compilitionHandler(result)
              print("Data Fetched Successfully...")
          } catch {
              print("error When Parseing data from API :  \(error.localizedDescription)")
              print(String(describing: error))

              compilitionHandler(nil)
          }
      case .failure(let error):
          print("Error When Featch data from API :  \(error.localizedDescription)")
          compilitionHandler(nil)
      }
    }

  }


}
