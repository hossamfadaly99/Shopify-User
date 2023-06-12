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
    
    var favArray:[Product]!
    
    init( dataManager: DataManagerProtocol!) {
        self.dataManager = dataManager
    }
//    func isExist(product:Product)->Bool{
//        return dataManager.isProductExist(myProduct: NadaProduct)
//    }
    func fetchDataFromDB()->[NadaProduct]?{
       return
        dataManager.getStoredProducts()
    }
    
    func deleteFromDB(product:Product){
        dataManager.deleteFavProduct(myProduct:product)
    }
}
