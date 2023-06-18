//
//  LocalSource.swift
//  Shopify User
//
//  Created by Hossam on 31/05/2023.
//


import Foundation

protocol DataManagerProtocol {
    func insertFavProduct(myProduct: ProductCoreData,productRate:Double)
    func getStoredProducts(user_id:String)-> [ProductCoreData]
    func deleteFavProduct(myProduct : ProductCoreData)
    func isProductExist(myProduct : ProductCoreData) -> Bool
}
