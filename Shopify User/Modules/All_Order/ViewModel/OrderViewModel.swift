//
//  OrderViewModel.swift
//  Shopify User
//
//  Created by Mac on 18/06/2023.
//

import Foundation
import Alamofire

class OrderViewModel{
    var CustomerID : String?
    var bindResultToViewController : (()->()) = {}
    var result : [Order]!{
        didSet{
            bindResultToViewController()
        }
    }
    //https://mad43-sv-ios3.myshopify.com/admin/api/2023-04/customers/6948853350692/orders.json
    
    func getItems(){
        let headers: HTTPHeaders = [
            HTTPHeader(name: "X-Shopify-Access-Token", value: "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")
               ]
        
        let url = "https://mad43-sv-ios3.myshopify.com/admin/api/2023-04/customers/\(CustomerID ?? "0")/orders.json"
        NetworkCallManager().loadData(url : url, param: Parameters(), header: headers) { [weak self] (result : OrderResponse? ,error) in
            self?.result = result?.orders
        }
    }

}
