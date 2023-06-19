//
//  OrderViewController.swift
//  Shopify User
//
//  Created by Mac on 18/06/2023.
//

import UIKit

class OrderViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    var ordersList : [Order] = []
    var viewModel : OrderViewModel?
    var customerID : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        setupViewModel()
        registerCustomerCell()
        
        // Do any additional setup after loading the view.
    }
    
    func setupViewModel(){
        viewModel=OrderViewModel()
        viewModel?.CustomerID = "6948853350692"
        
        viewModel?.bindResultToViewController={
            [weak self] in
            DispatchQueue.main.async {
                self?.ordersList = self?.viewModel?.result ?? []
                self?.tableView.reloadData()
            }
        }
        viewModel?.getItems()
    }
    
    func registerCustomerCell(){
        let  nib = UINib(nibName: "OrderCustomCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "order")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ordersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "order", for: indexPath) as! OrderCustomCell
        cell.orderIdLabel.text = "\(ordersList[indexPath.row].id ?? 0)"
        cell.orderDateLabel.text = ordersList[indexPath.row].createdAt
        cell.orderTotalPriceLabel.text = ordersList[indexPath.row].currentTotalPrice
        
        cell.contentView.frame = cell.orderIdLabel.frame.inset(by: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4))
        cell.contentView.layer.borderWidth = 2
        cell.contentView.layer.borderColor = UIColor.black.cgColor
        cell.contentView.layer.cornerRadius = 25
        
        return cell
    }
    

}
