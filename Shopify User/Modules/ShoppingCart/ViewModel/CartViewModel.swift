//
//  CartViewModel.swift
//  Shopify User
//
//  Created by Hossam on 08/06/2023.
//

import Foundation
class CartViewModel{
  var bindDataToView: ()->() = {}
  var bindEmptyListToView: ()->() = {}
  var networkManager: NetworkServiceProtocol
  var cartUpdated: DraftOrderr = DraftOrderr(draft_order: Draft_orders(line_items: []))
  var craftId: Int = 0
  var subTotalPrice = 0.0
  var indexx = 0

  var cartArray: [Line_items] = []{
    didSet{
      print("aaa2222")
      transferCartData()
      print("aaafinished")
      DispatchQueue.main.async {
        self.bindDataToView()
      }
    }
  }

  var isEmptyList: Bool = true {
    didSet{
      DispatchQueue.main.async {
        self.bindEmptyListToView()
      }
    }
  }

  init(networkManager: NetworkServiceProtocol) {
    self.networkManager = networkManager
  }

  func loadCartItems(){
    networkManager.setURL(URLCreator().getEditCartURL(id: "\(cartId)"))
    networkManager.fetchData{ [weak self] (result: DraftOrderr?) in
      //TODO change mail and add name to tags (like "cart")

//      print("lemlkrmlkemrlkm")
//      if result?.draft_orders == nil {
//        self?.isEmptyList.toggle()
//        self?.isEmptyList = true
//      }

      self?.craftId = cartId //result?.draft_orders?.filter({ $0.email == dummyMail && $0.note == "cart" }).first?.id ?? 0
      self?.subTotalPrice = Double(result?.draft_order?.subtotal_price ?? "0.0") ?? 0

//      print(result?.draft_orders)
//      if result?.draft_orders == nil { self?.isEmptyList = true; self?.cartArray = []}
      if let items = result?.draft_order?.line_items{


        print(self?.craftId ?? -1)
        print("kejbfbejhfbrhjebhj")
        if items.count == 1 && items.first?.title == "dummy for fav" {
          print("a")
          print(items.count)
          print(items.first?.title)
          self?.isEmptyList = true
        }else {
          print("b")
          print(items.count)
          print(items.first?.variant_id)
          self?.isEmptyList = false
          self?.cartArray = items
        }

      }
    }
  }

  func transferCartData(){
    cartUpdated.draft_order?.line_items = []
    for item in cartArray {
      var property = Properties(name: "img_url", value: item.properties?.first?.value)
      var lineItem = Line_items(variant_id: item.variant_id, quantity: item.quantity, properties: [property])
      cartUpdated.draft_order?.line_items?.append(lineItem)
    }
    print("ok")
  }

  func updateCartItem(cartItem: DraftOrderr){
    networkManager.setURL(URLCreator().getEditCartURL(id: String(describing: self.craftId)))

    networkManager.uploadData(object: cartItem, method: .put){ [weak self] (result: DraftOrderr?) in

      print("krbtkuygeksreykvbuyj")
      print("result: \(result)")

      self?.subTotalPrice = Double(result?.draft_order?.subtotal_price ?? "0.0") ?? 0.0
      self?.cartArray = result?.draft_order?.line_items ?? []
      print("rkjtbglrhtbg")
//      print(object)
      print(result)
        let items = result!.draft_order!.line_items!
      if items.count == 1 && items.first?.title == "dummy for fav" {
        print("a")
        print(items.count)
        print(items.first?.title)
        self?.isEmptyList = true
      }else {
        print("b")
        print(items.count)
        print(items.first?.variant_id)
        self?.isEmptyList = false
        self?.cartArray = items
      }


      print("krbtkuygeksreykvbuyj2222")
      print(self?.cartArray.first?.quantity)
    }
  }

}
