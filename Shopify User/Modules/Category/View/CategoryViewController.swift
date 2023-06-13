//
//  CategoryViewController.swift
//  Shopify User
//
//  Created by Mac on 09/06/2023.
//

import UIKit

class CategoryViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var productsList : [CategoryProduct] = []
    var productsListCopy : [CategoryProduct] = []
    var categoriesList : [CustomCollection] = []
    var viewModel : CategoryViewModel?
    @IBOutlet weak var categorySegment: UISegmentedControl!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var noItemFoundImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        noItemFoundImg.isHidden = true

        setupFloatingActionButton()
        registerNibFile()
        getCategories()
        
        // Do any additional setup after loading the view.
    }
    
    func registerNibFile(){
        let  nib = UINib(nibName: "ProductCustomViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "product")
    }
    
    func setupFloatingActionButton(){
        let floaty = Floaty()
        floaty.addItem("Accessiories",icon: UIImage(systemName: "medal.fill")) { item in
            self.productsList = self.productsListCopy
            self.productsList = self.productsList.filter({ $0.productType == "ACCESSORIES" })
            self.collectionView.reloadData()
        }
        floaty.addItem("Shoes",icon: UIImage(named: "shoes")){ item in
            self.productsList = self.productsListCopy
            self.productsList = self.productsList.filter({ $0.productType == "SHOES" })
            self.collectionView.reloadData()
        }
        floaty.addItem("Shirt",icon: UIImage(systemName: "tshirt.fill")){ item in
            self.productsList = self.productsListCopy
            self.productsList = self.productsList.filter({ $0.productType == "SHIRT" })
            self.collectionView.reloadData()
        }
        floaty.addItem("All",icon: UIImage(systemName: "list.bullet.clipboard")){ item in
            self.productsList = self.productsListCopy
            self.collectionView.reloadData()
        }
        floaty.translatesAutoresizingMaskIntoConstraints = false
        floaty.buttonColor = UIColor(named: "main_green") ?? UIColor(.black)
        floaty.friendlyTap = true
        self.view.addSubview(floaty)
        
        let constraints = [
            floaty.centerXAnchor.constraint(equalTo: view.trailingAnchor,constant: -16),
            floaty.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            floaty.widthAnchor.constraint(equalToConstant: 100),
            floaty.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func getCategories(){
        print("get categories")
        viewModel=CategoryViewModel()
        
        viewModel?.bindResultToViewController={
            [weak self] in
            DispatchQueue.main.async {
                self?.categoriesList = self?.viewModel?.customCollectionResult ?? []
                self?.getProducts()
                self?.collectionView.reloadData()
                for i in 0...3{
                    self?.categorySegment.setTitle(self?.categoriesList[i+1].handle?.capitalized, forSegmentAt: i)
                }
            }
        }
        viewModel?.getCustomCollection()
    }
    func getProducts(){
        print("get products")
        viewModel?.categoryID = categoriesList[categorySegment.selectedSegmentIndex+1].id
        
        viewModel?.bindResultToViewController={
            [weak self] in
            DispatchQueue.main.async {
                self?.productsList = self?.viewModel?.categoryResult ?? []
                self?.productsListCopy = self?.viewModel?.categoryResult ?? []
                self?.collectionView.reloadData()
            }
        }
        viewModel?.getItems()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if productsList.count == 0{
            noItemFoundImg.isHidden = false
        }else{
            noItemFoundImg.isHidden = true
        }
        return productsList.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "product", for: indexPath) as! ProductCustomViewCell
        
        cell.productLabelName.text = productsList[indexPath.row].title
        
        let url = URL(string: productsList[indexPath.row].image?.src ?? "")
        
        cell.productImg.kf.setImage(
            with: url,
            placeholder: UIImage(named: "team1"),
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        
        cell.productImg.frame = cell.productImg.frame.inset(by: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4))
        cell.productImg.layer.borderWidth = 2
        cell.productImg.layer.borderColor = UIColor.black.cgColor
        cell.productImg.layer.cornerRadius = 25
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width/2-10), height: 200)
    }
    
    @IBAction func segmentControlValueChanged(_ sender: UISegmentedControl) {
        getCategories()
    }
    
}
