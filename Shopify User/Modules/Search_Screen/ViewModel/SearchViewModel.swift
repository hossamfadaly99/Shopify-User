import UIKit
import RxRelay
import RxCocoa
import RxSwift
//protocol ActionDelegate {
//    func action(_ row: Int)
//}
class SearchViewModel {
    let dataViewModel = ProductsDetailsViewModel(networkManager: NetworkManager(url: ""),dataManager: DataManager.sharedInstance)

    var searchQuery: String = ""
    var products: PublishSubject<[Product]> = PublishSubject()
    var allProducts: [Product] = [] // Array to store all products
    var favoriteButtonTapped = PublishSubject<Product>()
    // Fetch products and populate the allProducts array
    func getProducts(urlString : String) {
        NetworkManager(url: urlString).fetchData { [weak self] (result: ProductResponse?) in
            guard let items = result?.products else { return }
            self?.allProducts = items
            let filteredProducts = self?.filterProducts() ?? []
            
            self?.products.onNext(filteredProducts)
        }
    }
    func getLocalProducts(items :[Product]){
        allProducts = items
        let filteredProducts = filterProducts()
        
        products.onNext(filteredProducts)
    }
    
    private func filterProducts() -> [Product] {
        guard !searchQuery.trimmingCharacters(in: .whitespaces).isEmpty else {
            return allProducts // Return all products if search text is empty or contains only whitespace characters
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
   
    
    func handleFavoriteButtonTapped(viewController: UIViewController,for product: Product) {
        print("My pro  :\(product)")
        guard let state = UserDefaults.standard.string(forKey: Constants.KEY_USER_STATE) else{return}
        guard let customer_id = UserDefaults.standard.string(forKey: Constants.KEY_USER_ID) else{return}
        if(state == Constants.USER_STATE_GUEST){
            AlertCreator.SignUpAlert(viewController: viewController)
        } else {
            let productCoreData = ProductCoreData(id: product.id,title: product.title,price: product.variants?[0].price,Pimage: product.image?.src,user_id: customer_id)
            
            let is_Exist = dataViewModel.isExistIntoDB(product: productCoreData)
            if is_Exist{
                let alert : UIAlertController = UIAlertController(title: "ALERT!", message: "ARE YOU SURE TO DELETE FROM FAVORITE?", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "YES", style: .default,handler: { [weak self] action in
                    //                    delete fromm fav
                    self?.dataViewModel.deleteFromDB(product: ProductCoreData(id: product.id,title: product.title,price: product.variants?[0].price,Pimage: product.image?.src,user_id: customer_id))
                    
                    self?.dataViewModel.bindCartData = { [weak self] in
                        var myDraft = self?.dataViewModel.wishListArray
                        var arr = myDraft?.line_items
                      //  print("Array before deletion \(arr)")
                        var myId = product.id
                      //  print("myId = \(myId)")

                        for i in 0..<(arr?.count ?? 0) {
                            var apiId = arr?[i].product_id
                          //  print("apiId = \(apiId)")
                            if (apiId == myId){
                                arr?.remove(at: i)
                                self?.dataViewModel.deleteFromDB(product:ProductCoreData(id: product.id,title: product.title,price: product.variants?[0].price,Pimage: product.image?.src,user_id: customer_id) )
                                break
                            }
                        }
                      //  print("Array after deletion \(arr)")

                        myDraft?.line_items? = arr ?? []
                        self?.dataViewModel.updateWishList(wishListItem: myDraft ?? Draft_orders())
                    }
                    self?.dataViewModel.loadWishListItems()
                    
                }))
                alert.addAction(UIAlertAction(title: "NO", style: .cancel,handler: nil))
                viewController.present(alert, animated: true, completion: nil)
            }
            else{
                //             insert to fav
//                dataViewModel.insertIntoDB(product:)
//                tableView.reloadData()
                
                dataViewModel.insertIntoDB(product:  ProductCoreData(id: product.id,title: product.title,price: product.variants?[0].price,Pimage: product.image?.src,user_id: customer_id))
               // favBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                dataViewModel.bindCartData = { [weak self] in
                    var myDraft = self?.dataViewModel.wishListArray
                    var arr = myDraft?.line_items
                    let pro = Constants().mapProductToLineItems(product: product )
                    arr?.append(pro)
                    myDraft?.line_items? = arr ?? []
                    self?.dataViewModel.updateWishList(wishListItem: myDraft ?? Draft_orders())
                }
                dataViewModel.loadWishListItems()
            }
       }
    }
}
