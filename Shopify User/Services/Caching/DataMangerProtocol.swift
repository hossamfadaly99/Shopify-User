//
//  LocalSource.swift
//  Shopify User
//
//  Created by Hossam on 31/05/2023.
//


import Foundation

protocol DataManagerProtocol {
    func insertFavProduct(myProduct: Product,productRate:Double) 
    func getStoredProducts() -> [Product]
    func deleteFavProduct(myProduct : Product)
    func isProductExist(myProduct : Product) -> Bool
}
