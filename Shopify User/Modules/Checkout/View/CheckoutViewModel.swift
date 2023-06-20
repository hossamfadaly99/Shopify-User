//
//  CheckoutViewModel.swift
//  Shopify User
//
//  Created by Mac on 19/06/2023.
//

import Foundation

class CheckoutViewModel{
    var bindResultToViewController : (()->()) = {}
    var bindDefaultAddress : (()->()) = {}
    var networkManager: NetworkServiceProtocol
    var orderResult : OrderPost!{
        didSet{
            bindResultToViewController()
        }
    }
  var orderRequest: OrderResponsePost = OrderResponsePost()
  var lineItems: [LineItem] = []
  var defaultAddress: Address_? {
    didSet{
      print("ksrhbvrjt")
      print(defaultAddress)
      bindDefaultAddress()
    }
  }
    
    init(networkManager: NetworkServiceProtocol) {
      self.networkManager = networkManager
    }
  func transferObject(items: [Line_items]){
    print("lrnbljgnblr")
    print(items.count)

    for item in items {
      var lineItem = LineItem()
      lineItem.variantID = item.variant_id
      lineItem.quantity = item.quantity
      self.lineItems.append(lineItem)
    }
    
  }
  func getDefaultAddress(){
    networkManager.setURL(URLCreator().getAddressURL(customerId: "6947695657252"))
    print(URLCreator().getAddressURL(customerId: "6947695657252"))
    networkManager.fetchData{[weak self] (result: Addresses?) in
      print("oueungejn")
      print(result)
      self?.defaultAddress = result?.addresses?.filter{ $0.addressDefault == true}.first
      print("oueungejn")
      print(self?.defaultAddress)
    }
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
