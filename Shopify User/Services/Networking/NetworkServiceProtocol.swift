//
//  NetworkServiceProtocol.swift
//  Shopify User
//
//  Created by Hossam on 08/06/2023.
//

import Foundation
import Alamofire
protocol NetworkServiceProtocol{
  func setURL(_ url: String)
  func fetchData<T: Codable>(compilitionHandler: @escaping (T?) -> Void)
  func uploadData<G: Codable, T: Codable>(object: G, method: HTTPMethod, compilitionHandler: @escaping (T?) -> Void)
  func updateData<G: Codable, T: Codable>(object: G, method: HTTPMethod, compilitionHandler: @escaping (T?) -> Void)
  func editItem<T: Encodable>(item: T, endPoint: String, completionHandler: @escaping (Bool) -> Void)
  func updateDataa<T: Codable>(compilitionHandler: @escaping (T?) -> Void)
  func deleteData<G: Codable>(object: G, compilitionHandler: @escaping () -> Void)
}
