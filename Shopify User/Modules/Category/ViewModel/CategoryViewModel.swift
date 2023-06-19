//
//  CategoryViewModel.swift
//  Shopify User
//
//  Created by Mac on 09/06/2023.
//

import Foundation
import Alamofire

class CategoryViewModel{
    var categoryID: Int?
    var bindResultToViewController : (()->()) = {}
    var customCollectionResult : [CustomCollection]!{
        didSet{
            bindResultToViewController()
        }
    }
    var categoryResult : [Product]!{
        didSet{
            bindResultToViewController()
        }
    }
    //https://mad43-sv-ios3.myshopify.com/admin/api/2023-04/products.json
    //https://mad43-sv-ios3.myshopify.com/admin/api/2023-04/custom_collections.json
    
    func getCustomCollection(){
        let headers: HTTPHeaders = [
            HTTPHeader(name: "X-Shopify-Access-Token", value: "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")
               ]
        
        let url = "https://mad43-sv-ios3.myshopify.com/admin/api/2023-04/custom_collections.json"
        MonicaNetworkManager().loadData(url : url, param: Parameters(), header: headers) { [weak self] (result : CategoryResponse? ,error) in
            self?.customCollectionResult = result?.customCollections
        }
    }
    
    
    
    func getItems(){
        let headers: HTTPHeaders = [
            HTTPHeader(name: "X-Shopify-Access-Token", value: "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")
               ]
               let param = ["collection_id": categoryID ?? 0]
        
        let url = "https://mad43-sv-ios3.myshopify.com/admin/api/2023-04/products.json"
        MonicaNetworkManager().loadData(url : url, param: param, header: headers) { [weak self] (result : ProductResponse? ,error) in
            self?.categoryResult = result?.products
        }
    }

}
