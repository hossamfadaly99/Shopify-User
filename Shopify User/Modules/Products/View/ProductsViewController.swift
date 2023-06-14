//
//  ProductsViewController.swift
//  Shopify User
//
//  Created by Mac on 04/06/2023.
//

import UIKit

class ProductsViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    var productsList : [Product] = []
    var viewModel : GetProductsViewModel?
    var brandName : String?
    @IBOutlet weak var noItemFoundImg: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        noItemFoundImg.isHidden = true
        let  nib = UINib(nibName: "ProductsTableCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "product")
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
                self?.tableView.reloadData()
            }
        }
        viewModel?.getItems()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "product", for: indexPath) as! ProductsTableCell
        
        cell.productPriceLabel.text = (productsList[indexPath.row].variants?[0].price ?? "0") + " EGP"
        cell.productTitleLabel.text = productsList[indexPath.row].title
        cell.productTypeLabel.text = productsList[indexPath.row].productType
        
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
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // -----try to show product details
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "ProductDetails_SB", bundle: nil) // Replace "Main" with your storyboard name
        let nextViewController = storyboard.instantiateViewController(withIdentifier: Constants.SCREEN_ID_PRODUCTSDETAILS) as! ProductDetails_VC
        //nextViewController.modalPresentationStyle = .fullScreen
        nextViewController.ID_Product_VC = productsList[indexPath.row].id
        present(nextViewController, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

}
