//
//  CartViewModel.swift
//  Shopify User
//
//  Created by Hossam on 08/06/2023.
//

import Foundation
class CartViewModel{
  var bindDataToView: ()->() = {}
  var networkManager: NetworkServiceProtocol

  var cartArray: [Line_items] = []{
    didSet{
      DispatchQueue.main.async {
        self.bindDataToView()
      }
    }
  }
  init(networkManager: NetworkServiceProtocol) {
    self.networkManager = networkManager
  }

  func loadCartItems(){
    networkManager.fetchData{ [weak self] (result: DraftOrders?) in
      //TODO change mail and add name to tags (like "cart")

      if let items = result?.draft_orders?.filter({ $0.email == dummyMail }).first?.line_items{

        self?.cartArray = items
      }
    }
  }

}
