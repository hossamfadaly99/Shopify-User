import UIKit
import RxRelay
import RxCocoa
import RxSwift

class SearchViewModel {
    var searchQuery: String = ""
    var products: PublishSubject<[Product]> = PublishSubject()
    var allProducts: [Product] = [] // Array to store all products
    
    // Fetch products and populate the allProducts array
    func getProducts() {
        NetworkManager(url: URLCreator().getProductsURL()).fetchData { [weak self] (result: ProductResponse?) in
            guard let items = result?.products else { return }
            self?.allProducts = items
            
            // Filter products based on the search query
            let filteredProducts = self?.filterProducts() ?? []
            
            self?.products.onNext(filteredProducts)
        }
    }

    private func filterProducts() -> [Product] {
        guard !searchQuery.isEmpty else {
            return allProducts // Return all products if search query is empty
        }
        
        let filteredProducts = allProducts.filter { product in
            // Replace 'title' with the appropriate property on your 'Product' model
            product.title?.lowercased().contains(searchQuery.lowercased()) ?? false
        }
        return filteredProducts
    }
    
    func updateSearchQuery(_ query: String) {
        searchQuery = query
        
        let filtered = filterProducts()
        products.onNext(filtered)
    }
}
