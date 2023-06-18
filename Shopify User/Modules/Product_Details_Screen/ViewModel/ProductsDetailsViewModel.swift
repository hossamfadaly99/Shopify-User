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
    var wishListArray: [Line_items] = []{
      didSet{
        DispatchQueue.main.async {
        }
      }
    }
    init(networkManager: NetworkServiceProtocol) {
      self.networkManager = networkManager
    }
    
    func loadWishListItems(){
    guard let wishlist_id = UserDefaults.standard.string(forKey: Constants.USER_WISHLIST) else {return}
      networkManager.fetchData{ [weak self] (result: DraftOrderr?) in
        if let items = result?.draft_order?.line_items{
        //  print(wishlist_id ?? -1)
          print("kejbfbejhfbrhjebhj")
          if items.count == 1 && items.first?.title == "dummy" {
            print("a")
            print(items.count)
       //     print(items.first?.title)
            self?.isEmptyList = true
          }else {
            print("b")
            print(items.count)
         //   print(items.first?.variant_id)
            self?.isEmptyList = false
            self?.wishListArray = items
          }
        }
          
      }
    }
    
  func getProductData (url:String){
      networkManager.setURL(url)
      networkManager.fetchData(compilitionHandler: {
          (result: ProductResponse?) in
          guard let item = result?.products?.first else{ return }
          self.myproduct = item
      })
    }
    
    func updateWishList (url:String,myParams:Parameters){
       
    }
}
