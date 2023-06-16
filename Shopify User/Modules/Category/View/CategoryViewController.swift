//
//  CategoryViewController.swift
//  Shopify User
//
//  Created by Mac on 09/06/2023.
//

import UIKit
import Reachability

class CategoryViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    var productsList : [Product] = []
    var productsListCopy : [Product] = []
    var categoriesList : [CustomCollection] = []
    var viewModel : CategoryViewModel?
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
            viewModel=CategoryViewModel()
            
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "product", for: indexPath) as! ProductsTableCell
        
        cell.productTitleLabel.text = productsList[indexPath.row].title
        cell.productTypeLabel.text = productsList[indexPath.row].productType
        cell.productPriceLabel.text = (productsList[indexPath.row].variants?[0].price ?? "0") + " EGP"
        
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
    
    @IBAction func segmentControlValueChanged(_ sender: UISegmentedControl) {
        getCategories()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
