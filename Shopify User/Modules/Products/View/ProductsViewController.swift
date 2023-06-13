//
//  ProductsViewController.swift
//  Shopify User
//
//  Created by Mac on 04/06/2023.
//

import UIKit

class ProductsViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var productsList : [Product] = []
    var viewModel : GetProductsViewModel?
    var brandName : String?
    @IBOutlet weak var noItemFoundImg: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        noItemFoundImg.isHidden = true
        let  nib = UINib(nibName: "ProductCustomViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "product")
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        viewModel=GetProductsViewModel()
        viewModel?.brandName = brandName
        
        viewModel?.bindResultToViewController={
            [weak self] in
            DispatchQueue.main.async {
                self?.productsList = self?.viewModel?.result ?? []
                if self?.productsList.count == 0{
                    self?.noItemFoundImg.isHidden = false
                }else{
                    self?.noItemFoundImg.isHidden = true
                }
                self?.collectionView.reloadData()
            }
        }
        viewModel?.getItems()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "product", for: indexPath) as! ProductCustomViewCell
        
        cell.productLabelName.text = productsList[indexPath.row].variants?[0].price
        
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
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // -----try to show product details
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "ProductDetails_SB", bundle: nil) // Replace "Main" with your storyboard name
    let nextViewController = storyboard.instantiateViewController(withIdentifier: Constants.SCREEN_ID_PRODUCTSDETAILS) as! ProductDetails_VC
        //nextViewController.modalPresentationStyle = .fullScreen
        nextViewController.product_VC = productsList[indexPath.row]
        present(nextViewController, animated: true, completion: nil)
        
    }


}
