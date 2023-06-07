//
//  ProductDetails_VC.swift
//  Shopify User
//
//  Created by MAC on 08/06/2023.
//

import UIKit

class ProductDetails_VC: UIViewController {
    @IBOutlet weak var myCollectionView: UICollectionView!
    var photosArray = [UIImage(named: "Facebook"),UIImage(named: "Facebook"),UIImage(named: "Facebook"),UIImage(named: "Facebook")]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}
extension ProductDetails_VC :UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as!Details_Cell
        cell.myImage.image = photosArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
}
