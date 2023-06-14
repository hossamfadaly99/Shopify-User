//
//  Search_VC.swift
//  Shopify User
//
//  Created by MAC on 14/06/2023.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay

class Search_VC: UIViewController {
    @IBOutlet weak var myTable: UITableView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var viewModel = SearchViewModel()
    let disposeBag = DisposeBag()

    var destination :String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        let  nib = UINib(nibName: "ProductsTableCell", bundle: nil)
        myTable.register(nib, forCellReuseIdentifier: "product")
        
        backBtn.rx.tap.asObservable().subscribe(onNext: { _ in
            self.dismiss(animated: true,completion: nil)
        }).disposed(by: disposeBag)
        setUpTableView()
        getData()
        
        searchFunctionality()
    }
    func searchFunctionality() {
        searchBar.rx.text.orEmpty
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .bind { [weak viewModel] query in
                viewModel?.updateSearchQuery(query)
            }
            .disposed(by: disposeBag)
    }


    func setUpTableView(){
        viewModel.products
            .asObservable() // Convert to observable sequence
            .bind(to: myTable.rx.items(cellIdentifier: "product",cellType: ProductsTableCell.self)){
                      index,element,cell in
                cell.productPriceLabel.text = (element.variants?[0].price ?? "0") + " EGP"
                cell.productTitleLabel.text = element.title
                cell.productTypeLabel.text = element.productType
        
                let url = URL(string: element.image?.src ?? "")
        
                cell.productImg.kf.setImage(
                    with: url,
                    placeholder: UIImage(named: "team1"))
        
                cell.productImg.frame = cell.productImg.frame.inset(by: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4))
                cell.productImg.layer.borderWidth = 2
                cell.productImg.layer.borderColor = UIColor.black.cgColor
                cell.productImg.layer.cornerRadius = 25
        
            }
            .disposed(by: disposeBag)
    }
    
    func getData(){
        viewModel.getProducts()
    }
}
extension Search_VC :UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 0
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "product", for: indexPath) as! ProductsTableCell
//
//        cell.productPriceLabel.text = (productsList[indexPath.row].variants?[0].price ?? "0") + " EGP"
//        cell.productTitleLabel.text = productsList[indexPath.row].title
//        cell.productTypeLabel.text = productsList[indexPath.row].productType
//
//        let url = URL(string: productsList[indexPath.row].image?.src ?? "")
//
//        cell.productImg.kf.setImage(
//            with: url,
//            placeholder: UIImage(named: "team1"))
//
//        cell.productImg.frame = cell.productImg.frame.inset(by: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4))
//        cell.productImg.layer.borderWidth = 2
//        cell.productImg.layer.borderColor = UIColor.black.cgColor
//        cell.productImg.layer.cornerRadius = 25
//
//        return cell
//    }
//
//
}
