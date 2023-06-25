//
//  ProductsViewController.swift
//  Shopify User
//
//  Created by Mac on 04/06/2023.
//

import UIKit
import DropDown
import Reachability
import PKHUD
import RxSwift
import RxCocoa
import RxRelay

class ProductsViewController: UIViewController , UITableViewDelegate, UITableViewDataSource , ReloadTableViewDelegate,ClickToFavBtnDelegate,UISearchBarDelegate{
    
    @IBOutlet weak var filterBtn: UIBarButtonItem!
    
    @IBOutlet weak var searchBar: UISearchBar!
    var productsList : [Product] = []
    var productsListCopy : [Product] = []
    var productCoreData : ProductCoreData!
    var productsListCopyForPrice : [Product] = []
    var productsPricesList : [Float] = []
    var productsTitlesList : [String] = []
    let dropDown = DropDown()
    var viewModel : GetProductsViewModel?
    var brandName : String?
    var comesFrom : Int?
    let disposeBag = DisposeBag()
    let dataViewModel = ProductsDetailsViewModel(networkManager: NetworkManager(url: ""),dataManager: DataManager.sharedInstance)

    var customer_id = UserDefaults.standard.string(forKey: Constants.KEY_USER_ID)
    @IBOutlet weak var noItemFoundImg: UIImageView!
    @IBOutlet weak var priceSliderOutlet: UISlider!
    @IBOutlet weak var priceFilterLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        noItemFoundImg.isHidden = true
        searchBar.delegate = self
        registerCell()
        setupDropDownMenu()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let searchText = searchBar.text else { return }
        productsList = productsListCopy
        let trimmedSearchText = searchText.replacingOccurrences(of: " ", with: "")
        let filteredResults = productsList.filter { $0.title?.localizedCaseInsensitiveContains(trimmedSearchText) ?? true }
        if trimmedSearchText != ""{
            productsList = filteredResults
        }
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        productsList = productsListCopy
        tableView.reloadData()
    }
    
    func registerCell(){
        let  nib = UINib(nibName: "ProductsTableCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "product")
    }
    
    func setupDropDownMenu(){
        dropDown.dataSource = ["Sort From A to Z","Sort By Price"]
        dropDown.anchorView = filterBtn// Replace 'yourButton' with the appropriate reference to your button
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            // Handle selection here
            if index == 0{
                self?.filterByA_Z()
            }else{
                self?.filterByPrice()
            }
        }
    }
    
    func filterByA_Z(){
        productsList = productsListCopy
        productsList.sort {
            $0.title ?? "No Title" < $1.title ?? "No Title"
        }
        productsListCopyForPrice = productsList
        tableView.reloadData()
    }
    
    func filterByPrice(){
        productsList = productsListCopy
        
        productsList.sort{
            if ($0.variants?[0].price)! == ($1.variants?[0].price)!{
                return ($0.title)! < ($1.title)!
            }
            return Double(($0.variants?[0].price)!) ?? 0 < Double(($1.variants?[0].price)!) ?? 0
        }
        productsListCopyForPrice = productsList
        tableView.reloadData()
    }
    
    @IBAction func filterBtnAcion(_ sender: UIBarButtonItem) {
        print("tapped")
        dropDown.show()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.center = self.view.center
        self.view.addSubview(indicator)
        indicator.color = UIColor(named: "main_green")
        indicator.startAnimating()
        
        let reachability = try! Reachability()
        if reachability.connection != .unavailable{
            viewModel = GetProductsViewModel()
            if comesFrom == 0{ // from home
                viewModel?.bindResultToViewController={
                    [weak self] in
                    DispatchQueue.main.async {
                        self?.productsList = self?.viewModel?.result ?? []
                        self?.productsListCopy = self?.viewModel?.result ?? []
                        self?.productsListCopyForPrice = self?.viewModel?.result ?? []
                        indicator.stopAnimating()
                        self?.setupSlider()
                        self?.tableView.reloadData()
                        HUD.hide(animated: true)
                    }
                }
                viewModel?.getAllProducts()
                
                
            }else if comesFrom == 1{ // from brands
               
                viewModel?.brandName = brandName
                
                viewModel?.bindResultToViewController={
                    [weak self] in
                    DispatchQueue.main.async {
                        self?.productsList = self?.viewModel?.result ?? []
                        self?.productsListCopy = self?.viewModel?.result ?? []
                        self?.productsListCopyForPrice = self?.viewModel?.result ?? []
                        indicator.stopAnimating()
                        self?.setupSlider()
                        self?.tableView.reloadData()
                        HUD.hide(animated: true)
                    }
                }
                viewModel?.getProductsBasedOnbrand()
               
            }else{ // from category
                productsListCopy = productsList
                productsListCopyForPrice = productsList
                indicator.stopAnimating()
                self.setupSlider()
                self.tableView.reloadData()
                HUD.hide(animated: true)
            }
        }
        else{
            let alert : UIAlertController = UIAlertController(title: "ALERT!", message: "No Connection", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel,handler: nil))
            indicator.stopAnimating()
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func setupSlider() {
        for i in self.productsList {
            self.productsPricesList.append(Float(i.variants?[0].price ?? "0") ?? 0)
            self.productsTitlesList.append(i.title ?? "No Title")
            print("Price: \(i.variants?[0].price ?? "0")")
        }
        priceSliderOutlet.minimumValue = 0

      priceSliderOutlet.maximumValue = (productsPricesList.max() ?? 0) * Float(currencyValue)
      priceSliderOutlet.value = (productsPricesList.max() ?? 0) * Float(currencyValue)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if productsList.count == 0{
            noItemFoundImg.isHidden = false
        }else{
            noItemFoundImg.isHidden = true
        }
        return productsList.count
    }
    func colorHeart(product:Product , favBtn : UIButton){
        let coreData = ProductCoreData(id: product.id,title: product.title,price: product.variants?[0].price,Pimage: product.image?.src,user_id: customer_id)
        //print("My p  :\(product_VC)")
        let is_Exist = dataViewModel.isExistIntoDB(product: coreData)
        if(is_Exist){
            favBtn.imageView?.image = UIImage(systemName: "heart.fill")
            print("product already saved")
        }else{
            favBtn.imageView?.image = UIImage(systemName: "heart")
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "product", for: indexPath) as! ProductsTableCell
      let amm: String = productsList[indexPath.row].variants?[0].price ?? "0"
      let am: Double = (Double(amm) ?? 0.0) * currencyValue
      var afterCurrency = String(format: "%.2f \(currencySymbol)", am)
      cell.productPriceLabel.text =  afterCurrency
//      cell.productPriceLabel.text = "\((Double(productsList[indexPath.row].variants?[0].price ?? "0") ?? 0.0) * currencyValue) \(currencySymbol)"

        cell.productTitleLabel.text = productsList[indexPath.row].title
        cell.productTypeLabel.text = productsList[indexPath.row].productType
        cell.cellIndex = indexPath.row
        cell.delegate = self
        
         let product = self.productsList[indexPath.row]
        colorHeart(product: product, favBtn: cell.favBtn)
         productCoreData = ProductCoreData(id: product.id,title: product.title,price: product.variants?[0].price,Pimage: product.image?.src,user_id: self.customer_id)
        let is_Exist = dataViewModel.isExistIntoDB(product: productCoreData)
        cell.setFavUI(isFav: is_Exist)
        let url = URL(string: productsList[indexPath.row].image?.src ?? "")
        
        cell.productImg.kf.setImage(
            with: url,
            placeholder: UIImage(named: "team1"))
        
        cell.productImg.frame = cell.productImg.frame.inset(by: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4))
        cell.productImg.layer.borderWidth = 2
        cell.productImg.layer.borderColor = UIColor.black.cgColor
        cell.productImg.layer.cornerRadius = 25
        
        return cell
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let reachability = try! Reachability()
        if reachability.connection != .unavailable{
            let storyboard = UIStoryboard(name: "ProductDetails_SB", bundle: nil) // Replace "Main" with your storyboard name
            let nextViewController = storyboard.instantiateViewController(withIdentifier: Constants.SCREEN_ID_PRODUCTSDETAILS) as! ProductDetails_VC
            //nextViewController.modalPresentationStyle = .fullScreen
            nextViewController.ID_Product_VC = productsList[indexPath.row].id
            nextViewController.favTableViewController = self
            present(nextViewController, animated: true, completion: nil)
        }
        else{
            let alert : UIAlertController = UIAlertController(title: "ALERT!", message: "No Connection", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel,handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    @IBAction func priceSlider(_ sender: UISlider) {
        priceFilterLabel.text = "From : \(Int(sender.minimumValue)) To \(Int(sender.value)) \(currencySymbol)"
        productsList = productsListCopyForPrice
        productsList = productsList.filter({ (Float($0.variants?[0].price ?? "0") ?? 0) * Float(currencyValue) <= sender.value})
        tableView.reloadData()
    }
    func reloadTableView() {
        self.tableView.reloadData()
    }
    
    func clicked(_ row: Int) {
        //print("My p  :\(product_VC)")
        guard let state = UserDefaults.standard.string(forKey: Constants.KEY_USER_STATE) else{return}
        if(state == Constants.USER_STATE_GUEST){
            AlertCreator.SignUpAlert(viewController: self)
        } else {
            let product = productsList[row]
            productCoreData = ProductCoreData(id: product.id,title: product.title,price: product.variants?[0].price,Pimage: product.image?.src,user_id: self.customer_id)
            
            let is_Exist = dataViewModel.isExistIntoDB(product: productCoreData)
            if is_Exist{
                let alert : UIAlertController = UIAlertController(title: "ALERT!", message: "ARE YOU SURE TO DELETE FROM FAVORITE?", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "YES", style: .default,handler: { [weak self] action in
                    //                    delete fromm fav
                    self?.dataViewModel.deleteFromDB(product: ProductCoreData(id: product.id,title: product.title,price: product.variants?[0].price,Pimage: product.image?.src,user_id: self?.customer_id))
                    self?.tableView.reloadData()
                    
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
                                self?.dataViewModel.deleteFromDB(product:ProductCoreData(id: product.id,title: product.title,price: product.variants?[0].price,Pimage: product.image?.src,user_id: self?.customer_id) )
                                break
                            }
                        }
                      //  print("Array after deletion \(arr)")

                        myDraft?.line_items? = arr ?? []
                        self?.dataViewModel.updateWishList(wishListItem: myDraft ?? Draft_orders())
                    }
                    self?.dataViewModel.loadWishListItems()
                    
                }))
                alert.addAction(UIAlertAction(title: "NO", style: .cancel,handler: { [weak self] action in
                    self?.tableView.reloadData()
                }))
                present(alert, animated: true, completion: nil)
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
                tableView.reloadData()
            }
       }
    }
}

