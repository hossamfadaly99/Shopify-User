//
//  CategoryViewController.swift
//  Shopify User
//
//  Created by Mac on 09/06/2023.
//

import UIKit

class CategoryViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var productsList : [CategoryProduct] = []
    var categoriesList : [CustomCollection] = []
    var viewModel : CategoryViewModel?
    @IBOutlet weak var categorySegment: UISegmentedControl!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        let  nib = UINib(nibName: "ProductCustomViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "product")
        
        getCategories()

        // Do any additional setup after loading the view.
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
        viewModel?.categoryID = categoriesList[categorySegment.selectedSegmentIndex].id
        print("iddd \(categoriesList[categorySegment.selectedSegmentIndex].id)")
        
        viewModel?.bindResultToViewController={
            [weak self] in
            DispatchQueue.main.async {
                self?.productsList = self?.viewModel?.categoryResult ?? []
                print("countttt \(self?.productsList.count)")
                print(self?.productsList[0].title)
                self?.collectionView.reloadData()
            }
        }
        viewModel?.getItems()

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
        return CGSize(width: (UIScreen.main.bounds.width/3-10), height: 200)
    }
    
    @IBAction func segmentControlValueChanged(_ sender: UISegmentedControl) {
        getCategories()
    }
    
}
