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
    var bindDataToView:((Product) -> ()) = { _ in }
    var myproduct: Product = Product(){
      didSet{
          bindDataToView(self.myproduct)
      }
    }
    
    
  func getProductData (url:String){
      NetworkManager(url: url).fetchData{
          (result: ProductResponse?) in
          guard let item = result?.products?.first else{ return }
          self.myproduct = item
      }
    }
    func updateWishList (url:String,myParams:Parameters){
        Network.updateDraft(url: url, myParams: myParams, responseType: DraftOrderr.self) { (draftorder:DraftOrderr?)  in
            print("Updated:\(draftorder?.draft_order)")
        }
        
    }
}
