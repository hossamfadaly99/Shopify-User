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

class ProductsDetailsViewModel{
//    var myProduct :PublishSubject<Product> = PublishSubject()
//    let reloadData = PublishSubject<Void>()
//    let isLoading : PublishSubject<Bool> = PublishSubject()
   
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
    
    
//
//    func getProductData(url: String) {
//        isLoading.onNext(true)
//        guard let urlFinal = URL(string: url) else { return }
//
//        var request = URLRequest(url: urlFinal)
//        request.allHTTPHeaderFields = [
//            //"Content-Type": "application/json",
//            "X-Shopify-Access-Token": "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"
//        ]
//        request.httpMethod = "GET"
//        let session = URLSession.shared
//        let task = session.dataTask(with: request) { data, response, error in
//            guard let data = data else { return }
//            print(data)
//            do {
//                let result = try JSONDecoder().decode(ProductResponse.self, from: data)
//                self.isLoading.onNext(false)
//                self.myProduct.onNext(result.products?.first ?? Product())
//                print("My Product ID From API: \(result.products?[0].id ?? 0)")
//            } catch let error {
//                print(error.localizedDescription)
//            }
//        }
//        task.resume()
//    }

}
