//
//  FavouriteViewModel.swift
//  Shopify User
//
//  Created by MAC on 12/06/2023.
//

import Foundation
class FavouritViewModel{
    var dataManager : DataManagerProtocol!
    
    var bindResultToView : (()->()) = {}
    
    var favArray:[ProductCoreData]!
    
    init( dataManager: DataManagerProtocol!) {
        self.dataManager = dataManager
    }
    func fetchDataFromDB(user_ID:String)->[ProductCoreData]?{
       return
        dataManager.getStoredProducts(user_id: user_ID)
    }
    func deleteFromDB(product:ProductCoreData){
        dataManager.deleteFavProduct(myProduct:product)
    }
    
    func isExistIntoDB(product:ProductCoreData) -> Bool{
        return dataManager.isProductExist(myProduct:product)
    }
    func insertIntoDB(product:ProductCoreData){
        dataManager.insertFavProduct(myProduct:product, productRate: 2.5)
    }
    
}
