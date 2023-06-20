//
//  ProductsViewModel.swift
//  Shopify User
//
//  Created by Mac on 04/06/2023.
//

import Foundation
import Alamofire

class GetProductsViewModel{
    var brandName : String?
    var bindResultToViewController : (()->()) = {}
    var result : [Product]!{
        didSet{
            bindResultToViewController()
        }
    }
    
    var dataManager : DataManagerProtocol!
    
    init( dataManager: DataManagerProtocol!) {
        self.dataManager = dataManager
    }
    //https://mad43-sv-ios3.myshopify.com/admin/api/2023-04/products.json
    
    func getItems(){
        let headers: HTTPHeaders = [
            HTTPHeader(name: "X-Shopify-Access-Token", value: "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")
               ]
   // https://mad43-sv-ios3.myshopify.com/admin/api/2023-04/products.json?vendor=ASICS TIGER
               let param = ["vendor": brandName ?? "ADIDAS"]
        
        let url = "https://mad43-sv-ios3.myshopify.com/admin/api/2023-04/products.json"
        MonicaNetworkManager().loadData(url : url, param: param, header: headers) { [weak self] (result : ProductResponse? ,error) in
            self?.result = result?.products
        }
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
