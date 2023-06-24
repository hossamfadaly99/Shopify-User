//
//  OrderDetailsViewController.swift
//  Shopify User
//
//  Created by Mac on 24/06/2023.
//

import UIKit

class OrderDetailsViewController: UIViewController, UICollectionViewDelegate , UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var order : Order?
    var lineItems : [LineItem]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        lineItems = order?.lineItems

        // Do any additional setup after loading the view.
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        lineItems?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath) as! OrderItemCustomCell
        cell.itemTitle.text = lineItems?[indexPath.row].name
        cell.itemQuantity.text = "\( lineItems?[indexPath.row].quantity ?? 0)"
        let url = URL(string: lineItems?[indexPath.row].properties?.first?.value ?? "")
        
        cell.itemImg.kf.setImage(
            with: url,
            placeholder: UIImage(named: "team1"))
        
        return cell
    }

}
