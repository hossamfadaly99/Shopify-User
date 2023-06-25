//
//  Reviews_VC.swift
//  Shopify User
//
//  Created by MAC on 12/06/2023.
//

import UIKit

class Reviews_VC: UIViewController {
    @IBOutlet weak var myTableView: UITableView!
    let reviewManager = Reviews()
    var reviewArray :[(String,String,String)] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.register(UINib(nibName: "reviewCell", bundle: nil), forCellReuseIdentifier: "reviewCell")
        reviewArray += reviewManager.getReviews(numberOfReviews: 15)
    }
    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true,completion: nil)
    }
}
extension Reviews_VC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(80)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell", for: indexPath) as!reviewCell
        cell.reviewLabel.text = reviewArray[indexPath.row].0
        cell.name.text = reviewArray[indexPath.row].1
        cell.img.image = UIImage(named: reviewArray[indexPath.row].2)
        return cell
    }
}
