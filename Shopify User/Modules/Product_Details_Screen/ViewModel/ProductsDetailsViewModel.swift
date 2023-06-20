//
//  ProductsDetailsViewModel.swift
//  Shopify User
//
//  Created by MAC on 10/06/2023.
//

import Foundation
import RxRelay
import RxCocoa
import RxSwift
import Alamofire

class ProductsDetailsViewModel{
    var bindCartData: ()->() = {}
    var networkManager: NetworkServiceProtocol
    let defaults = UserDefaults.standard
    var bindDataToView:((Product) -> ()) = { _ in }
    var myproduct: Product = Product(){
      didSet{
          bindDataToView(self.myproduct)
      }
    }
    var isEmptyList: Bool = true
    var wishListArray: Draft_orders = Draft_orders(){
        didSet{
            bindCartData()
        }
      }
    
    init(networkManager: NetworkServiceProtocol) {
      self.networkManager = networkManager
    }
    
    func loadWishListItems(){
    guard let wishlist_id = UserDefaults.standard.string(forKey: Constants.USER_WISHLIST) else {return}
        networkManager.setURL(URLCreator().getEditCartURL(id: String(describing: wishlist_id)))
        networkManager.fetchData(compilitionHandler: { [weak self] (result: DraftOrderr?) in
            if let items = result?.draft_order?.line_items{
              if items.count == 1 && items.first?.title == "dummy" {
               // print("items a")
                print(items.count)
                  print(items.first?.title)
                self?.isEmptyList = true
                  self?.wishListArray = result?.draft_order ?? Draft_orders()

                 // print("hjjjjjjjjjjjj\(items)")
              }else {
                print("items b")
                print(items.count)
                  print(items.first?.title)
                self?.isEmptyList = false
                  self?.wishListArray = result?.draft_order ?? Draft_orders()
                  print("hjjjjjjjjjjjj\(items)")
              }
            }
          })
    }

    
    func updateWishList (wishListItem: Draft_orders){
        guard let wishlist_id = UserDefaults.standard.string(forKey: Constants.USER_WISHLIST) else {return}

        networkManager.setURL(URLCreator().getEditCartURL(id: String(describing: wishlist_id)))
        networkManager.editItem(item: wishListItem, endPoint: "") { res in
            print ("result \(res)")
        }

//        networkManager.uploadData(object: wishListItem, method: .put){ [weak self] (result: DraftOrderr?) in
//
//          print("result: \(result)")
////            let items = result?.draft_order?.line_items
////          if items.count == 1 && items.first?.title == "dummy" {
////            print("a")
////            print("a :\(items.count)")
////            print(items.first?.title)
////            self?.isEmptyList = true
////          }else {
////            print("b")
////            print("b :\(items.count)")
////            print(items.first?.variant_id)
////            self?.isEmptyList = false
////          }
//        }
    }
    func getProductData (url:String){
        networkManager.setURL(url)
        networkManager.fetchData(compilitionHandler: {
            (result: ProductResponse?) in
            guard let item = result?.products?.first else{ return }
            self.myproduct = item
        })
      }
}
