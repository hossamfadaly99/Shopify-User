//
//  CategoryViewController.swift
//  Shopify User
//
//  Created by Mac on 09/06/2023.
//

import UIKit
import Reachability

class CategoryViewController: UIViewController , UITableViewDelegate, UITableViewDataSource, ReloadTableViewDelegate,ClickDelegate{
    
    var productsList : [Product] = []
    var productsListCopy : [Product] = []
    var productCoreData : ProductCoreData!
    var categoriesList : [CustomCollection] = []
    var viewModel : CategoryViewModel?
    let dataManager = DataManager.sharedInstance
    var customer_id = UserDefaults.standard.string(forKey: Constants.KEY_USER_ID)
    @IBOutlet weak var categorySegment: UISegmentedControl!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noItemFoundImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        noItemFoundImg.isHidden = true
        setupFloatingActionButton()
        registerNibFile()
        getCategories()
    }
    
    func registerNibFile(){
        let  nib = UINib(nibName: "ProductsTableCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "product")
    }
    
    func setupFloatingActionButton(){
        let floaty = Floaty()
        floaty.addItem("Accessiories",icon: UIImage(systemName: "medal.fill")) { item in
            self.productsList = self.productsListCopy
            self.productsList = self.productsList.filter({ $0.productType == "ACCESSORIES" })
            self.tableView.reloadData()
        }
        floaty.addItem("Shoes",icon: UIImage(named: "shoes")){ item in
            self.productsList = self.productsListCopy
            self.productsList = self.productsList.filter({ $0.productType == "SHOES" })
            self.tableView.reloadData()
        }
        floaty.addItem("Shirt",icon: UIImage(systemName: "tshirt.fill")){ item in
            self.productsList = self.productsListCopy
            self.productsList = self.productsList.filter({ $0.productType == "SHIRT" })
            self.tableView.reloadData()
        }
        floaty.addItem("All",icon: UIImage(systemName: "list.bullet.clipboard")){ item in
            self.productsList = self.productsListCopy
            self.tableView.reloadData()
        }
        floaty.translatesAutoresizingMaskIntoConstraints = false
        floaty.buttonColor = UIColor(named: "main_green") ?? UIColor(.black)
        floaty.friendlyTap = true
        self.view.addSubview(floaty)
        
        let constraints = [
            floaty.centerXAnchor.constraint(equalTo: view.trailingAnchor,constant: -16),
            floaty.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            floaty.widthAnchor.constraint(equalToConstant: 100),
            floaty.heightAnchor.constraint(equalToConstant: 50)]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func getCategories(){
        print("get categories")
        
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.center = self.view.center
        self.view.addSubview(indicator)
        indicator.color = UIColor(named: "main_green")
        indicator.startAnimating()
        
        let reachability = try! Reachability()
        if reachability.connection != .unavailable{
            viewModel=CategoryViewModel(dataManager: dataManager)
            
            viewModel?.bindResultToViewController={
                [weak self] in
                DispatchQueue.main.async {
                    self?.categoriesList = self?.viewModel?.customCollectionResult ?? []
                    self?.getProducts()
                    indicator.stopAnimating()
                    self?.tableView.reloadData()
                    for i in 0...3{
                        self?.categorySegment.setTitle(self?.categoriesList[i+1].handle?.capitalized, forSegmentAt: i)
                    }
                }
            }
            viewModel?.getCustomCollection()
        }
        else{
            let alert : UIAlertController = UIAlertController(title: "ALERT!", message: "No Connection", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel,handler: nil))
            indicator.stopAnimating()
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func getProducts(){
        print("get products")
        viewModel?.categoryID = categoriesList[categorySegment.selectedSegmentIndex+1].id
        
        viewModel?.bindResultToViewController={
            [weak self] in
            DispatchQueue.main.async {
                self?.productsList = self?.viewModel?.categoryResult ?? []
                self?.productsListCopy = self?.viewModel?.categoryResult ?? []
                self?.tableView.reloadData()
            }
        }
        viewModel?.getItems()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
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
        let is_Exist = dataManager.isProductExist(myProduct: coreData)
        if(is_Exist){
            favBtn.imageView?.image = UIImage(systemName: "heart.fill")
            print("product already saved")
        }else{
            favBtn.imageView?.image = UIImage(systemName: "heart")
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "product", for: indexPath) as! ProductsTableCell
        
        cell.productTitleLabel.text = productsList[indexPath.row].title
        cell.productTypeLabel.text = productsList[indexPath.row].productType
        cell.productPriceLabel.text = (productsList[indexPath.row].variants?[0].price ?? "0") + " EGP"
        cell.cellIndex = indexPath.row
        cell.delegate = self
        
        let product = self.productsList[indexPath.row]
        colorHeart(product: product, favBtn: cell.favBtn)
        productCoreData = ProductCoreData(id: product.id,title: product.title,price: product.variants?[0].price,Pimage: product.image?.src,user_id: self.customer_id)
        let is_Exist = dataManager.isProductExist(myProduct: productCoreData)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let reachability = try! Reachability()
        if reachability.connection != .unavailable{
            let storyboard = UIStoryboard(name: "ProductDetails_SB", bundle: nil) // Replace "Main" with your storyboard name
            let nextViewController = storyboard.instantiateViewController(withIdentifier: Constants.SCREEN_ID_PRODUCTSDETAILS) as! ProductDetails_VC
            //nextViewController.modalPresentationStyle = .fullScreen
            nextViewController.ID_Product_VC = productsList[indexPath.row].id
            present(nextViewController, animated: true, completion: nil)
        }
        else{
            let alert : UIAlertController = UIAlertController(title: "ALERT!", message: "No Connection", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel,handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func segmentControlValueChanged(_ sender: UISegmentedControl) {
        getCategories()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    @IBAction func navigateToFav(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Favourite_SB", bundle: nil)
        let nextViewController = storyboard.instantiateViewController(withIdentifier: Constants.SCREEN_ID_FAVOURITE) as! Favourite_VC
       nextViewController.modalPresentationStyle = .fullScreen
        present(nextViewController, animated: true, completion: nil)
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
    
    func reloadTableView() {
        self.tableView.reloadData()
    }
    func clicked(_ row: Int) {
        //print("My p  :\(product_VC)")
        let product = productsList[row]
        productCoreData = ProductCoreData(id: product.id,title: product.title,price: product.variants?[0].price,Pimage: product.image?.src,user_id: self.customer_id)
        
         let is_Exist = dataManager.isProductExist(myProduct: productCoreData)
         if is_Exist{
            let alert : UIAlertController = UIAlertController(title: "ALERT!", message: "ARE YOU SURE TO DELETE FROM FAVORITE?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "YES", style: .default,handler: { [weak self] action in
//                    delete fromm fav
                self?.viewModel?.deleteFromDB(product: ProductCoreData(id: product.id,title: product.title,price: product.variants?[0].price,Pimage: product.image?.src,user_id: self?.customer_id))
                self?.tableView.reloadData()
                
            }))
             alert.addAction(UIAlertAction(title: "NO", style: .cancel,handler: { [weak self] action in
                 self?.tableView.reloadData()
             }))
            present(alert, animated: true, completion: nil)
        }
        else{
//             insert to fav
            viewModel?.insertIntoDB(product: ProductCoreData(id: product.id,title: product.title,price: product.variants?[0].price,Pimage: product.image?.src,user_id: customer_id))
            tableView.reloadData()
        }
    }
}
