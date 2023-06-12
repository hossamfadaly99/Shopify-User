//
//  LocalSource.swift
//  Shopify User
//
//  Created by Hossam on 31/05/2023.
//


import Foundation

protocol DataManagerProtocol {
    func insertFavProduct(myProduct: NadaProduct,productRate:Double)
    func getStoredProducts() -> [NadaProduct]
    func deleteFavProduct(myProduct : Product)
    func isProductExist(myProduct : NadaProduct) -> Bool
}
