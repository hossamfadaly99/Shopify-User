////
////  CartViewModel.swift
////  Shopify User
////
////  Created by Hossam on 08/06/2023.
////
//
//import Foundation
//class CartViewModel{
//  var bindDataToView: ()->() = {}
//  var bindEmptyListToView: ()->() = {}
//  var networkManager: NetworkServiceProtocol
//  var craftId: Int = 0
//  var subTotalPrice = 0.0
//
//  var cartArray: [Line_items] = []{
//    didSet{
//      DispatchQueue.main.async {
//        self.bindDataToView()
//      }
//    }
//  }
//
//  var isEmptyList: Bool = true {
//    didSet{
//      DispatchQueue.main.async {
//        self.bindEmptyListToView()
//      }
//    }
//  }
//
//  init(networkManager: NetworkServiceProtocol) {
//    self.networkManager = networkManager
//  }
//
//  func loadCartItems(){
//    networkManager.fetchData{ [weak self] (result: DraftOrders?) in
//      //TODO change mail and add name to tags (like "cart")
//
//      print("lemlkrmlkemrlkm")
//      self?.craftId = result?.draft_orders?.filter({ $0.email == dummyMail && $0.note == "cart" }).first?.id ?? 0
//      self?.subTotalPrice = Double(result?.draft_orders?.filter({ $0.email == dummyMail && $0.note == "cart" }).first?.subtotal_price ?? "0.0") ?? 0
//
//
//      if let items = result?.draft_orders?.filter({ $0.email == dummyMail && $0.note == "cart" }).first?.line_items{
//
//        print(self?.craftId ?? -1)
//        if items.count == 1 && items.first?.title == "dummy for ward"{
//          self?.isEmptyList = true
//        }else {
//          self?.isEmptyList = false
//          self?.cartArray = items
//        }
//
//      }
//    }
//  }
//
//  func updateCartItem(cartItem: DraftOrderEdited){
//    networkManager.setURL(URLCreator().getEditCartURL(id: String(describing: self.craftId)))
//
//    networkManager.uploadData(object: cartItem){ [weak self] (result: Draft_orders?) in
//      print("krbtkuygeksreykvbuyj")
//      print(result?.line_items?.first?.quantity ?? -111)
//
//    }
//  }
//
//}
