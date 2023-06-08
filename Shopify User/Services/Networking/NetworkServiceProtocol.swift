//
//  NetworkServiceProtocol.swift
//  Shopify User
//
//  Created by Hossam on 08/06/2023.
//

import Foundation
protocol NetworkServiceProtocol{
  func setURL(_ url: String)
  func fetchData<T: Codable>(compilitionHandler: @escaping (T?) -> Void)
}
