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
//    var customerID : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        setupViewModel()
        registerCustomerCell()
    }
    
    func setupViewModel(){
        viewModel=OrderViewModel()
        viewModel?.CustomerID = "\(storedCustomerId)"
        
        viewModel?.bindResultToViewController={
            [weak self] in
            DispatchQueue.main.async {
                self?.ordersList = self?.viewModel?.result ?? []
                print("orderlist : \(self?.ordersList)")
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
        cell.orderDateLabel.text = "\(ordersList[indexPath.row].createdAt?.split(separator: "T").first ?? "")"
      var afterCurrency = String(format: "%.2f \(currencySymbol)", ((Double(ordersList[indexPath.row].currentTotalPrice ?? "0.0") ?? 0.0) + 10.0) * currencyValue)
      cell.orderTotalPriceLabel.text = afterCurrency
        
        cell.contentView.frame = cell.orderIdLabel.frame.inset(by: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4))
        cell.contentView.layer.borderWidth = 2
        cell.contentView.layer.borderColor = UIColor.black.cgColor
        cell.contentView.layer.cornerRadius = 25
        
        return cell
    }
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          return CGFloat(120)

  }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      tableView.deselectRow(at: indexPath, animated: true)
        let storyboard = UIStoryboard(name: "HomeStoryboard", bundle: nil) // Replace "Main" with your storyboard name
        let nextViewController = storyboard.instantiateViewController(withIdentifier: "orderDetails") as! OrderDetailsViewController
        //nextViewController.modalPresentationStyle = .fullScreen
        nextViewController.order = ordersList[indexPath.row]
        present(nextViewController, animated: true, completion: nil)
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
