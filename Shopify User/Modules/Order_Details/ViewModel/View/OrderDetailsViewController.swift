//
//  OrderDetailsViewController.swift
//  Shopify User
//
//  Created by Mac on 24/06/2023.
//

import UIKit

class OrderDetailsViewController: UIViewController, UITableViewDelegate , UITableViewDataSource{
    
    @IBOutlet weak var orderDateLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var orderIDLabel: UILabel!
   
    @IBOutlet weak var tableView: UITableView!
    var viewModel : OrderDetailsViewModel?
    var order : Order?
    var lineItems : [LineItem]?

    override func viewDidLoad() {
        super.viewDidLoad()
        lineItems = order?.lineItems
        registerCell()
        // Do any additional setup after loading the view.
    }
    func registerCell(){
        let  nib = UINib(nibName: "OrderItemsTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "item")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel = OrderDetailsViewModel()
        orderIDLabel.text = "\(order?.id ?? 0)"
        addressLabel.text = order?.shippingAddress?.address1
        totalPriceLabel.text = order?.totalPrice
        orderDateLabel.text = "\(order?.createdAt?.split(separator: "T").first ?? "")"
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        lineItems?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "item", for: indexPath) as! OrderItemsTableViewCell
        cell.itemTitle.text = "\(lineItems?[indexPath.row].quantity ?? 0) X \(lineItems?[indexPath.row].name ?? "")"
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
