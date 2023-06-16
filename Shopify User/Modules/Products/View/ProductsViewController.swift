//
//  ProductsViewController.swift
//  Shopify User
//
//  Created by Mac on 04/06/2023.
//

import UIKit
import DropDown
import Reachability

class ProductsViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var filterBtn: UIBarButtonItem!
    var productsList : [Product] = []
    var productsListCopy : [Product] = []
    var productsListCopyForPrice : [Product] = []
    var productsPricesList : [Float] = []
    var productsTitlesList : [String] = []
    let dropDown = DropDown()
    var viewModel : GetProductsViewModel?
    var brandName : String?
    @IBOutlet weak var noItemFoundImg: UIImageView!
    @IBOutlet weak var priceSliderOutlet: UISlider!
    @IBOutlet weak var priceFilterLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        noItemFoundImg.isHidden = true
        let  nib = UINib(nibName: "ProductsTableCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "product")
        
        setupDropDownMenu()
    }
    
    func setupDropDownMenu(){
        //dropDown.dataSource = ["By bestseller", "By A-Z","By Price"]
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
    
//    func filterByBestSeller(){
//        productsList = productsListCopy
//        productsListCopyForPrice = productsList
//        tableView.reloadData()
//    }
    
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
            viewModel=GetProductsViewModel()
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
                }
            }
            viewModel?.getItems()
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
        priceSliderOutlet.maximumValue = productsPricesList.max() ?? 0
        priceSliderOutlet.value = productsPricesList.max() ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if productsList.count == 0{
            noItemFoundImg.isHidden = false
        }else{
            noItemFoundImg.isHidden = true
        }
        return productsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "product", for: indexPath) as! ProductsTableCell
        
        cell.productPriceLabel.text = (productsList[indexPath.row].variants?[0].price ?? "0") + " EGP"
        cell.productTitleLabel.text = productsList[indexPath.row].title
        cell.productTypeLabel.text = productsList[indexPath.row].productType
        
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
        priceFilterLabel.text = "From : \(Int(sender.minimumValue)) To \(Int(sender.value))"
        productsList = productsListCopyForPrice
        productsList = productsList.filter({ Float($0.variants?[0].price ?? "0") ?? 0 <= sender.value})
        tableView.reloadData()
    }
}
