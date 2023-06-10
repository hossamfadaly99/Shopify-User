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
    var myProduct :PublishSubject<Product> = PublishSubject()
    let reloadData = PublishSubject<Void>()
    let isLoading : PublishSubject<Bool> = PublishSubject()
    
    func getProductData (url:String){
        isLoading.onNext(true)
        let url = URL(string: url)
        guard let urlFinal = url else{ return }
        let request = URLRequest(url: urlFinal)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, responce, error in
        guard let data = data else{ return }
            do{
                let result = try JSONDecoder().decode(Product.self, from: data)
                self.isLoading.onNext(false)
                self.myProduct.onNext(result)
                print ("My Product Name From API : \(result.title)")
                    
            }catch let error{
                print (error.localizedDescription)
                    
            }
        }
        task.resume()
    }
}
