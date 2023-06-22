//
//  Search_VC.swift
//  Shopify User
//
//  Created by MAC on 14/06/2023.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay

class Search_VC: UIViewController {
    @IBOutlet weak var myTable: UITableView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    let dataViewModel = ProductsDetailsViewModel(networkManager: NetworkManager(url: ""),dataManager: DataManager.sharedInstance)
    var viewModel = SearchViewModel()
    var productsArray:[Product] = []
    let disposeBag = DisposeBag()
    var brand :String = ""
    
    var destination :String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        let  nib = UINib(nibName: "SearchCell", bundle: nil)
        
        myTable.register(nib, forCellReuseIdentifier: "SearchCell")
        
        backBtn.rx.tap.asObservable().subscribe(onNext: { _ in
            self.dismiss(animated: true,completion: nil)
        }).disposed(by: disposeBag)
        switch destination {
        case Constants.HOME_SEARCH_ICON :
          //  var brandProducts = viewModel.products.asObserver()
            setUpTableView()
            getData(url: URLCreator().getProductsURL())
            searchFunctionality()
            break
        case Constants.SCREEN_ID_BRAND :
            setUpTableView()
            getData(url: URLCreator().getBrandProducts(brandName: brand))
            searchFunctionality()
            break
        case Constants.SCREEN_ID_CATEGORY :
            setUpTableView()
            viewModel.getLocalProducts(items: productsArray) 
            searchFunctionality()
        default:
            print("")
        }
        
    }
    func searchFunctionality() {
        searchBar.rx.text.orEmpty
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .bind { [weak viewModel] query in
                viewModel?.updateSearchQuery(query)
            }
            .disposed(by: disposeBag)
    }
    
    
    func setUpTableView(){
        viewModel.products
            .asObservable() // Convert to observable sequence
            .bind(to: myTable.rx.items(cellIdentifier: "SearchCell", cellType: SearchCell.self)){
                      index,element,cell in

                let aastring: String = element.variants?[0].price ?? "0.0"
                let aa: Double = (Double(aastring) ?? 0.0) * currencyValue
                let afterCurrency = String(format: "%.2f \(currencySymbol)", aa)
                cell.productPriceLabel.text = afterCurrency //"\(aa) \(currencySymbol)"
                cell.productTitleLabel.text = element.title
                cell.productTypeLabel.text = element.productType
        
                let url = URL(string: element.image?.src ?? "")
        
                cell.productImg.kf.setImage(
                    with: url,
                    placeholder: UIImage(named: "team1"))
        
                cell.productImg.frame = cell.productImg.frame.inset(by: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4))
                cell.productImg.layer.borderWidth = 2
                cell.productImg.layer.borderColor = UIColor.black.cgColor
                cell.productImg.layer.cornerRadius = 25
                
               // let productCoreData:ProductCoreData = ProductCoreData(id: element.id,title: element.title,price: element.variants?[0].price,Pimage: element.image?.src,user_id: self.customer_id)
                var p = Constants().mapProductToProductCD(product: element)
                let is_Exist = self.dataViewModel.isExistIntoDB(product: p)
                cell.setFavUI(isFav: is_Exist)
                cell.favBtn.rx.tap.asObservable().subscribe(onNext: {
                    print("Heart Tapped")
                    self.viewModel.handleFavoriteButtonTapped(viewController: self ,for: element)
                })
                .disposed(by: self.disposeBag)
        
            }
            .disposed(by: disposeBag)
        
        myTable.rx.modelSelected(Product.self)
                .subscribe(onNext: { [weak self] product in
                    // Handle selected item here
                    self?.handleItemSelected(product)
                })
                .disposed(by: disposeBag)
        
//        viewModel.favoriteButtonTapped
//            .subscribe(onNext: { [weak self] myproduct in
//                // Handle favorite button action for the product
//                print("Heart Tapped")
//                self?.viewModel.handleFavoriteButtonTapped(viewController: self! ,for: myproduct)
//            })
//            .disposed(by: disposeBag)
    }
    
    func handleItemSelected(_ product: Product) {
      //  print("Selected product: \(product.title)")
        let storyboard = UIStoryboard(name: "ProductDetails_SB", bundle: nil) // Replace "Main" with your storyboard name
        let nextViewController = storyboard.instantiateViewController(withIdentifier: Constants.SCREEN_ID_PRODUCTSDETAILS) as! ProductDetails_VC
        //nextViewController.modalPresentationStyle = .fullScreen
        nextViewController.ID_Product_VC = product.id
        present(nextViewController, animated: true, completion: nil)
        
    }
    
    func getData(url:String){
        viewModel.getProducts(urlString: url)
    }

    
}


extension Search_VC :UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
