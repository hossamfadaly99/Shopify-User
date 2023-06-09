//
//  HomeViewModel.swift
//  Shopify User
//
//  Created by Mac on 04/06/2023.
//

import Foundation
import Alamofire

class HomeViewModel{
    var bindResultToViewController : (()->()) = {}
    var result : [SmartCollection]!{
        didSet{
            bindResultToViewController()
        }
    }
    
    func getItems(){
//        let param = ["met":"Leagues","APIkey":"fb7419108b900032b89d25268411cef54132de43ba4ceec5dd189418a60a6d33"]
        let headers: HTTPHeaders = [
            HTTPHeader(name: "X-Shopify-Access-Token", value: "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")
               ]
        let url = "https://mad43-sv-ios3.myshopify.com/admin/api/2023-04/smart_collections.json"
        MonicaNetworkManager().loadData(url : url,param: Parameters(),header: headers) { [weak self] (result : Response? ,error) in
            self?.result = result?.smart_collections
        }
    }

}
