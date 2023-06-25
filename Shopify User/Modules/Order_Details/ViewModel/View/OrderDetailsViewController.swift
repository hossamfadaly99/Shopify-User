//
//  OrderDetailsViewController.swift
//  Shopify User
//
//  Created by Mac on 24/06/2023.
//

import UIKit

class OrderDetailsViewController: UIViewController, UITableViewDelegate , UITableViewDataSource{
    
//    @IBOutlet weak var orderView: UIView!
//    @IBOutlet weak var orderDateLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var orderIDLabel: UILabel!

  @IBOutlet weak var customerNameLabel: UILabel!

  @IBOutlet weak var tableView: UITableView!
    var viewModel : OrderDetailsViewModel?
    var order : Order?
    var lineItems : [LineItem]?

    override func viewDidLoad() {
        super.viewDidLoad()
//      tableView.layer.borderColor = CGColor(red: 152, green: 152, blue: 152, alpha: 255)
        lineItems = order?.lineItems
//        orderView.layer.cornerRadius = 16
//        orderView.layer.borderWidth = 0.5
        registerCell()
        // Do any additional setup after loading the view.
    }
    func registerCell(){
//        let  nib = UINib(nibName: "OrderItemsTableViewCell", bundle: nil)
//        tableView.register(nib, forCellReuseIdentifier: "item")
        let  nib = UINib(nibName: "CustomOrderCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CustomOrderCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel = OrderDetailsViewModel()
      customerNameLabel.text = "\(order?.shippingAddress?.firstName ?? "") \(order?.shippingAddress?.lastName ?? "")"
        orderIDLabel.text = "#\(order?.id ?? 0)"
        addressLabel.text = order?.shippingAddress?.address1
      var afterCurrency = String(format: "%.2f \(currencySymbol)", ((Double(order?.totalPrice ?? "0.0") ?? 0.0) + 10) * currencyValue)
        totalPriceLabel.text = afterCurrency
//        orderDateLabel.text = "\(order?.createdAt?.split(separator: "T").first ?? "")"
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        lineItems?.count ?? 0

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "item", for: indexPath) as! OrderItemsTableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomOrderCell", for: indexPath) as! CustomOrderCell
      cell.productName.text = "\(lineItems?[indexPath.row].name?.split(separator: "-").first ?? "" )"
      cell.quantityLabel.text = "X \(lineItems?[indexPath.row].quantity ?? 0)"
//        cell.itemTitle.text = "\(lineItems?[indexPath.row].quantity ?? 0) X \(lineItems?[indexPath.row].name ?? "")"
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }


}
