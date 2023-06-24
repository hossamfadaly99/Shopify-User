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
    var dataManager : DataManagerProtocol!
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
    
    init(networkManager: NetworkServiceProtocol,dataManager: DataManagerProtocol) {
      self.networkManager = networkManager
        self.dataManager = dataManager
    }
    func fetchDataFromDB(user_ID:String)->[ProductCoreData]?{
       return
        dataManager.getStoredProducts(user_id: user_ID)
    }
    func deleteFromDB(product:ProductCoreData){
        dataManager.deleteFavProduct(myProduct:product)
    }
    
    func isExistIntoDB(product:ProductCoreData) -> Bool{
        return dataManager.isProductExist(myProduct:product)
    }
    func insertIntoDB(product:ProductCoreData){
        dataManager.insertFavProduct(myProduct:product, productRate: 2.5)
    }
    func loadWishListItems(){
    guard let wishlist_id = UserDefaults.standard.string(forKey: Constants.USER_WISHLIST) else {return}
        networkManager.setURL(URLCreator().getEditCartURL(id: String(describing: wishlist_id)))
        networkManager.fetchData(compilitionHandler: { [weak self] (result: DraftOrderr?) in
            if let items = result?.draft_order?.line_items{
              if items.count == 1 && items.first?.title == "dummy" {
               // print("items a")
              //  print(items.count)
               //   print(items.first?.title)
                self?.isEmptyList = true
                  self?.wishListArray = result?.draft_order ?? Draft_orders()
              }else {
               // print("items b")
                print(items.count)
                 // print(items.first?.title)
                self?.isEmptyList = false
                  self?.wishListArray = result?.draft_order ?? Draft_orders()
                 // print("hjjjjjjjjjjjj\(items)")
              }
            }
          })
    }

    
    func updateWishList (wishListItem: Draft_orders){
        guard let wishlist_id = UserDefaults.standard.string(forKey: Constants.USER_WISHLIST) else {return}
      //  print("Updated wishList ID:\(wishlist_id) ")
        networkManager.setURL(URLCreator().getEditCartURL(id: String(describing: wishlist_id)))
        networkManager.editItem(item: wishListItem, endPoint: "") { res in
        //    print ("result \(res)")
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
    
    
}
