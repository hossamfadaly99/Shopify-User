//
//  ProductDetails_VC.swift
//  Shopify User
//
//  Created by MAC on 08/06/2023.
//

import UIKit
import RxSwift
import RxRelay
import RxCocoa
import Cosmos

class ProductDetails_VC: UIViewController {
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var review1: UILabel!
    @IBOutlet weak var review2: UILabel!
    @IBOutlet weak var review3: UILabel!
    @IBOutlet weak var cosmosView: CosmosView!
    @IBOutlet weak var addToFav: UIImageView!
    var product_VC : Product!
    var photosArray:[ProductImage]?
    var timer:Timer?
    var currentIndex = 0
    let viewModel = ProductsDetailsViewModel()
    let dataManager = DataManager.sharedInstance
    var reviewsList :[String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view did load")
        let reviews = Reviews()
        reviewsList = reviews.getReviews(numberOfReviews: 3)
        photosArray = product_VC.images
        pageController.numberOfPages = photosArray?.count ?? 0
        myCollectionView.reloadData()
        startTimer()
        productName.text = product_VC.title
        productPrice.text = product_VC.variants?[0].price
        productDescription.text = product_VC.description
        review1.text = reviewsList[0]
        review2.text = reviewsList[1]
        review3.text = reviewsList[2]
    }
    @objc func imageTapped(_ gesture: UITapGestureRecognizer) {
        //let p = NadaProduct(id: product_VC.id,title: product_VC.title,price: product_VC.variants?[0].price,Pimage: product_VC.image?.src)
        print("My p  :\(product_VC)")
        let is_Exist = dataManager.isProductExist(myProduct: product_VC)
        if(is_Exist){
            print("product already saved")
        }else{
            guard let myProduct = product_VC else{return}
            print("product to be inserted\(myProduct)")
            dataManager.insertFavProduct(myProduct: product_VC, productRate: 2.5)
            addToFav.image = UIImage(named: "activated")
            print("Product Saved !")
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        print("view did appear")
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
        addToFav.addGestureRecognizer(tapGesture)
        addToFav.isUserInteractionEnabled = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
       // let p = NadaProduct(id: product_VC.id,title: product_VC.title,price: product_VC.variants?[0].price,Pimage: product_VC.image?.src)
        print("view will appear")
        let is_Exist2 = dataManager.isProductExist(myProduct: product_VC)
        print(is_Exist2)

        if(is_Exist2){
            print("hiii")
            addToFav.image = UIImage(named: "activated")
        }
    }
    
    @IBAction func showMoreReviews(_ sender: Any) {
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: Constants.SCREEN_ID_REVIEWS) as! Reviews_VC
            nextViewController.modalPresentationStyle = .fullScreen
            nextViewController.reviewArray = reviewsList
            present(nextViewController, animated: true, completion: nil)
    }
    
    @IBAction func addToCart(_ sender: Any) {
    }
    
    
}
extension ProductDetails_VC :
   UITableViewDelegate
,UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout
{
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(moveToTheNextItemInCollection), userInfo: nil, repeats: true)
    }

    @objc func moveToTheNextItemInCollection(){
        if(currentIndex < (photosArray?.count ?? 0) - 1){
            currentIndex += 1
        } else {
            currentIndex = 0
        }
        myCollectionView.scrollToItem(at: IndexPath(item:  currentIndex,section: 0), at: .centeredHorizontally, animated: true)
        pageController.currentPage = currentIndex
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosArray?.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CELL_ID_PODUCT_DETAILS, for: indexPath) as!Details_Cell
      //  print("kkkkkkkkkkk")
        cell.myImage.kf.setImage(with: URL(string:photosArray?[indexPath.row].src ?? ""))
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
  
}
