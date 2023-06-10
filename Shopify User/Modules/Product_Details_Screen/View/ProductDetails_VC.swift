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

class ProductDetails_VC: UIViewController {
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var pageController: UIPageControl!
//    var photosArray = [UIImage(named: "Baseball"),UIImage(named: "1"),UIImage(named: "Baseball"),UIImage(named: "Facebook")]
    var photosArray:[String]?
    var timer:Timer?
    var currentIndex = 0
    let viewModel = ProductsDetailsViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageController.numberOfPages = photosArray?.count ?? 0
        startTimer()
        getData()
        setUpCollection()
    }
    
    func setUpCollection(){
        viewModel.myProduct
            .asObservable() // Convert to observable sequence
            .map { product in
                product.images ?? []
            }
            .bind(to: myCollectionView.rx.items(cellIdentifier: Constants.CELL_ID_PODUCT_DETAILS,cellType: Details_Cell.self)){
                      index,element,cell in
                cell.myImage.kf.setImage(with: URL(string:element.src ?? ""))
            }
            .disposed(by: disposeBag)
    }
    
    func getData(){
        viewModel.getProductData(url: "https://mad43-sv-ios3.myshopify.com/admin/api/2023-04/products.json?ids=8355419586852")
    }
}
extension ProductDetails_VC :
   // UITableViewDelegate
//,UICollectionViewDataSource,
//UICollectionViewDelegateFlowLayout
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
    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return photosArray?.count ?? 0
//    }
    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as!Details_Cell
//        cell.myImage.image = photosArray[indexPath.row]
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
    
}
