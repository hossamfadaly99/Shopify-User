//
//  OrderDetailsViewModel.swift
//  Shopify User
//
//  Created by Mac on 25/06/2023.
//

import Foundation
import Alamofire

class OrderDetailsViewModel{
    var productTitle : String?
    var bindResultToViewController : (()->()) = {}
    var result : [Product]!{
        didSet{
            bindResultToViewController()
        }
    }
    
    
    //https://mad43-sv-ios3.myshopify.com/admin/api/2023-04/products.json
    
    func getProduct(){
        let headers: HTTPHeaders = [
            HTTPHeader(name: "X-Shopify-Access-Token", value: "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")
               ]
   // https://mad43-sv-ios3.myshopify.com/admin/api/2023-04/products.json?vendor=ASICS TIGER
               let param = ["title": productTitle ?? "ADIDAS"]
        
        let url = "https://mad43-sv-ios3.myshopify.com/admin/api/2023-04/products.json"
        NetworkCallManager().loadData(url : url, param: param, header: headers) { [weak self] (result : ProductResponse? ,error) in
            self?.result = result?.products
        }
    }
}
