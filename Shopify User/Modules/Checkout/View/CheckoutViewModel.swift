//
//  CheckoutViewModel.swift
//  Shopify User
//
//  Created by Mac on 19/06/2023.
//

import Foundation

class CheckoutViewModel{
    var bindResultToViewController : (()->()) = {}
    var networkManager: NetworkServiceProtocol
    var orderResult : OrderPost!{
        didSet{
            bindResultToViewController()
        }
    }
    
    init(networkManager: NetworkServiceProtocol) {
      self.networkManager = networkManager
    }
    //https://mad43-sv-ios3.myshopify.com/admin/api/2023-04/customers/6948853350692/orders.json
    
    func createOrder(orderItem:OrderResponsePost){
        networkManager.setURL(URLCreator().getCreateOrder())
        print("increateorder")
        print(orderItem)
        networkManager.uploadData(object: orderItem, method: .post){ [weak self] (result: OrderResponsePost?) in
            
            self?.orderResult = result?.order
        }

    }

}
