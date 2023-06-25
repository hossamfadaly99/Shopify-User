//
//  ProductsViewModel.swift
//  Shopify User
//
//  Created by Mac on 04/06/2023.
//

import Foundation
import Alamofire
import RxRelay
import RxCocoa
import RxSwift

class GetProductsViewModel{
    var brandName : String?
    var searchQuery: String = ""
    var products: PublishSubject<[Product]> = PublishSubject()
    var bindResultToViewController : (()->()) = {}
    var result : [Product]!{
        didSet{
            bindResultToViewController()
        }
    }
    
    
    //https://mad43-sv-ios3.myshopify.com/admin/api/2023-04/products.json
    
    func getProductsBasedOnbrand(){
        let headers: HTTPHeaders = [
            HTTPHeader(name: "X-Shopify-Access-Token", value: "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")
               ]
   // https://mad43-sv-ios3.myshopify.com/admin/api/2023-04/products.json?vendor=ASICS TIGER
               let param = ["vendor": brandName ?? "ADIDAS"]
        
        let url = "https://mad43-sv-ios3.myshopify.com/admin/api/2023-04/products.json"
        NetworkCallManager().loadData(url : url, param: param, header: headers) { [weak self] (result : ProductResponse? ,error) in
            self?.result = result?.products
        }
    }
    func getAllProducts(){
        let headers: HTTPHeaders = [
            HTTPHeader(name: "X-Shopify-Access-Token", value: "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")
               ]
   // https://mad43-sv-ios3.myshopify.com/admin/api/2023-04/products.json
        
        let url = "https://mad43-sv-ios3.myshopify.com/admin/api/2023-04/products.json"
        NetworkCallManager().loadData(url : url, param: Parameters(), header: headers) { [weak self] (result : ProductResponse? ,error) in
            self?.result = result?.products
        }
    }
    
    
    func updateSearchQuery(_ query: String) {
        searchQuery = query
        
        let filtered = filterProducts()
        products.onNext(filtered)
    }
    private func filterProducts() -> [Product] {
        guard !searchQuery.trimmingCharacters(in: .whitespaces).isEmpty else {
            return result // Return all products if search text is empty or contains only whitespace characters
        }
        
        let filteredProducts = result.filter { product in
            // Replace 'title' with the appropriate property on your 'Product' model
            product.title?.lowercased().contains(searchQuery.lowercased()) ?? false
        }
        return filteredProducts
    }
    

}
