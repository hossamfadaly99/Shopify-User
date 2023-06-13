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
    @IBOutlet weak var cosmosView: CosmosView!
    @IBOutlet weak var addToFav: UIImageView!
    @IBOutlet weak var size: UILabel!
    
    @IBOutlet weak var reviewsTable: UITableView!
   
    @IBOutlet weak var labeldes: UILabel!
    
    var ID_Product_VC : Int!
    var product_VC :Product = Product()
    var photosArray:[ProductImage]?
    var timer:Timer?
    var currentIndex = 0
    let viewModel = ProductsDetailsViewModel()
    let dataManager = DataManager.sharedInstance
    var reviewsList :[(String,String,String)] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        let reviews = Reviews()
        self.reviewsList = reviews.getReviews(numberOfReviews: 3)
        reviewsTable.register(UINib(nibName: "reviewCell", bundle: nil), forCellReuseIdentifier: "reviewCell")
        print("view did load")
       // print(ID_Product_VC)
        viewModel.bindDataToView = { product in
            self.product_VC = product
            self.photosArray = self.product_VC.images
            self.pageController.numberOfPages = self.photosArray?.count ?? 0
            self.startTimer()
            self.productName.text = self.product_VC.title
            self.productPrice.text = self.product_VC.variants?[0].price
            
            //self.size.text = self.product_VC.variants
            self.labeldes.text = self.product_VC.description
//            self.review1.text = self.reviewsList[0].0
//            self.review2.text = self.reviewsList[1].0
//            self.review3.text = self.reviewsList[2].0
            self.myCollectionView.reloadData()
            
        }
        let pid = String(ID_Product_VC)
        viewModel.getProductData(url:URLCreator().getProductURL(id: pid) )
    }
    @objc func imageTapped(_ gesture: UITapGestureRecognizer) {
        let coreData = ProductCoreData(id: product_VC.id,title: product_VC.title,price: product_VC.variants?[0].price,Pimage: product_VC.image?.src)
        print("My p  :\(product_VC)")
        let is_Exist = dataManager.isProductExist(myProduct: coreData)
        if(is_Exist){
            print("product already saved")
        }else{
          //  guard let myProduct = coreData else{return}
            print("product to be inserted\(coreData)")
            dataManager.insertFavProduct(myProduct: coreData, productRate: 2.5)
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
        let coreData = ProductCoreData(id: product_VC.id,title: product_VC.title,price: product_VC.variants?[0].price,Pimage: product_VC.image?.src)
        print("view will appear")
        let is_Exist2 = dataManager.isProductExist(myProduct: coreData)
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

extension ProductDetails_VC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(80)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell", for: indexPath) as!reviewCell
        cell.reviewLabel.text = reviewsList[indexPath.row].0
        cell.name.text = reviewsList[indexPath.row].1
        cell.img?.layer.cornerRadius = (cell.img?.frame.size.width ?? 70) / 2
        cell.img?.clipsToBounds = true
        cell.img.image = UIImage(named: reviewsList[indexPath.row].2)
        return cell
    }
    
}
extension ProductDetails_VC :
   UICollectionViewDelegate
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

