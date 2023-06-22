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
   // @IBOutlet weak var addToFav: UIImageView!
    @IBOutlet weak var reviewsTable: UITableView!
    @IBOutlet weak var labeldes: UILabel!
    @IBOutlet weak var popUpBtn: UIButton!
    
    @IBOutlet weak var favBtn: UIButton!
    var favTableViewController : ReloadTableViewDelegate?
    
    var customer_id = UserDefaults.standard.string(forKey: Constants.KEY_USER_ID)
    var ID_Product_VC : Int!
    var sizes : [String]?
    var product_VC :Product = Product()
    var photosArray:[ProductImage]?
    var timer:Timer?
    var currentIndex = 0
    let viewModel = ProductsDetailsViewModel(networkManager: NetworkManager(url: ""),dataManager: DataManager.sharedInstance)
    let dataManager = DataManager.sharedInstance
    var reviewsList :[(String,String,String)] = []
    let cartViewModel = CartViewModel(networkManager: NetworkManager(url: URLCreator().getEditCartURL(id: "\(cartId)")))
  
    override func viewDidLoad() {
        super.viewDidLoad()
        let reviews = Reviews()
        self.reviewsList = reviews.getReviews(numberOfReviews: 3)
        reviewsTable.register(UINib(nibName: "reviewCell", bundle: nil), forCellReuseIdentifier: "reviewCell")

        viewModel.bindDataToView = { product in
            self.product_VC = product
            guard let variants = self.product_VC.variants else { return }
            //print("sizes : \(variants.count)")
            self.sizes = []
               for item in variants {
                   self.sizes?.append(item.title ?? "No sizes")
                 //  print("sizes : \(item.title)")
               }
            self.setPopUpButton()
            self.photosArray = self.product_VC.images
            self.pageController.numberOfPages = self.photosArray?.count ?? 0
            self.startTimer()
            self.productName.text = self.product_VC.title
          var afterCurrency = String(format: "%.2f \(currencySymbol)", (Double(self.product_VC.variants?[0].price ?? "0.0") ?? 0.0) * currencyValue)
          self.productPrice.text = afterCurrency
        //  print("liwurhgiuohlitg")
        //  print(currencyValue)
            self.labeldes.text = self.product_VC.description
            self.myCollectionView.reloadData()
            self.colorHeart()
        }
        let pid = String(ID_Product_VC)
        viewModel.getProductData(url:URLCreator().getProductURL(id: pid) )
        cartViewModel.bindDataToView = {

      }
    }
    
    @IBAction func addToFav(_ sender: Any) {
        guard let state = UserDefaults.standard.string(forKey: Constants.KEY_USER_STATE) else{return}
        if(state == Constants.USER_STATE_GUEST){
            AlertCreator.SignUpAlert(viewController: self)
        } else {
            let coreData = ProductCoreData(id: product_VC.id,title: product_VC.title,price: product_VC.variants?[0].price,Pimage: product_VC.image?.src,user_id: customer_id)
            let is_Exist = viewModel.isExistIntoDB(product: coreData)
            if(is_Exist){
                let alert : UIAlertController = UIAlertController(title: "ALERT!", message: "ARE YOU SURE TO DELETE FROM FAVORITE?", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "YES", style: .default,handler: { [weak self] action in
                    //                    delete fromm fav
                    self?.viewModel.bindCartData = { [weak self] in
                        var myDraft = self?.viewModel.wishListArray
                        var arr = myDraft?.line_items
                      //  print("Array before deletion \(arr)")
                        var myId = coreData.id
                      //  print("myId = \(myId)")

                        for i in 0..<(arr?.count ?? 0) {
                            var apiId = arr?[i].product_id
                          //  print("apiId = \(apiId)")
                            if (apiId == myId){
                                arr?.remove(at: i)
                                self?.viewModel.deleteFromDB(product:coreData )
                                break
                            }
                        }
                      //  print("Array after deletion \(arr)")

                        myDraft?.line_items? = arr ?? []
                        self?.viewModel.updateWishList(wishListItem: myDraft ?? Draft_orders())
                    }
                    self?.viewModel.loadWishListItems()
                    self?.favBtn.setImage(UIImage(systemName: "heart"), for: .normal)
                    
                }))
                alert.addAction(UIAlertAction(title: "NO", style: .cancel,handler:nil))
                present(alert, animated: true, completion: nil)
            }else{
                viewModel.insertIntoDB(product: coreData) 
                favBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                viewModel.bindCartData = { [weak self] in
                    var myDraft = self?.viewModel.wishListArray
                    var arr = myDraft?.line_items
                    let pro = Constants().mapProductToLineItems(product: self?.product_VC ?? Product())
                    arr?.append(pro)
                    myDraft?.line_items? = arr ?? []
                    self?.viewModel.updateWishList(wishListItem: myDraft ?? Draft_orders())
                }
                viewModel.loadWishListItems()
            }
        }
    }

    
    func colorHeart(){
        guard let state = UserDefaults.standard.string(forKey: Constants.KEY_USER_STATE) else{return}
        if(state == Constants.USER_STATE_GUEST){
            favBtn.setImage(UIImage(systemName: "heart"), for: .normal)        } else {
            let coreData = ProductCoreData(id: product_VC.id,title: product_VC.title,price: product_VC.variants?[0].price,Pimage: product_VC.image?.src,user_id: customer_id)
            //print("My p  :\(product_VC)")
            let is_Exist = dataManager.isProductExist(myProduct: coreData)
            if(is_Exist){
                favBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
             //   print("product already saved")
            }else{
                favBtn.setImage(UIImage(systemName: "heart"), for: .normal)
            }
        }
    }
    
    @IBAction func showMoreReviews(_ sender: Any) {
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: Constants.SCREEN_ID_REVIEWS) as! Reviews_VC
            nextViewController.modalPresentationStyle = .fullScreen
            nextViewController.reviewArray = reviewsList
            present(nextViewController, animated: true, completion: nil)
    }
    
    @IBAction func addToCart(_ sender: Any) {
        guard let state = UserDefaults.standard.string(forKey: Constants.KEY_USER_STATE) else{return}
        if(state == Constants.USER_STATE_GUEST){
            AlertCreator.SignUpAlert(viewController: self)
        } else {
           // print("mlutgiuv5hiubtrhu")
           // print(customer_id)
          //  print(cartId)
         //   print(favvvId)
            var arr: [Line_items] = (self.cartViewModel.cartArray)
            //cartViewModel.cartUpdated.daraftOrder?.line_Items = arr
            if arr.count > 0 //!(arr.count == 1 && arr.first?.title == "empty product" )
            { //!(1 & empty product)
               // print("mlutgiuv5hiubtrhu22")
                //          (self.cartViewModel.cartUpdated.draft_order?.line_items)!.filter{ $0.variant_id == 123456789 }
                for (index, element) in arr.enumerated() {
                 //   print("ketgbrjtkg elemnt: \(index)")
             //       print(element)
                    if element.variant_id == viewModel.myproduct.variants?.first?.id {
                      //  print("found variant id")
                        self.cartViewModel.indexx = index
                        self.cartViewModel.cartUpdated.draft_order?.line_items?[index].quantity! += 1
                     //   print("ketgbrjtkg line items")
                        //            print(self.cartViewModel.cartUpdated.draft_order?.line_items)
                        self.cartViewModel.updateCartItem(cartItem: self.cartViewModel.cartUpdated)
                        return
                    }
                }
                
                let newItem: Line_items = Line_items(variant_id: viewModel.myproduct.variants?.first?.id, quantity: 1, properties: [Properties(name: "img_url", value: self.photosArray?.first?.src)])
               // print("lsrthvuilrhbjkntrlhuigigiithy")
               // print(self.cartViewModel.cartUpdated.draft_order?.line_items)
                self.cartViewModel.cartUpdated.draft_order?.line_items?.append(newItem)
              //  print(self.cartViewModel.cartUpdated.draft_order?.line_items)
                self.cartViewModel.updateCartItem(cartItem: self.cartViewModel.cartUpdated)
            } else {
                let newItem: Line_items = Line_items(variant_id: viewModel.myproduct.variants?.first?.id, quantity: 1, properties: [Properties(name: "img_url", value: self.photosArray?.first?.src)])
                self.cartViewModel.cartUpdated.draft_order?.line_items = [newItem]
                self.cartViewModel.updateCartItem(cartItem: self.cartViewModel.cartUpdated)
            }
            //      self.cartViewModel.updateCartItem(cartItem: self.cartViewModel.cartUpdated)
        }
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

extension ProductDetails_VC  {
    func setPopUpButton(){
        var action :[UIAction] = []
        let optionSelected = {(action : UIAction) in
            //show selected size title
            print(action.title)
        }
        guard let sizes = sizes else {return}
        if (sizes.isEmpty){
            action.append( UIAction(title: "Sizes", handler: optionSelected) )
        } else {
            action = []
            for item in sizes{
                action.append( UIAction(title: item, handler: optionSelected))
                //action.state = .on
               // print("func :")
            }
            
        }
        popUpBtn.menu = UIMenu(children: action)
        popUpBtn.showsMenuAsPrimaryAction = true
        popUpBtn.changesSelectionAsPrimaryAction = true
    }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    cartViewModel.loadCartItems()
  }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        favTableViewController?.reloadTableView()
    }
}
