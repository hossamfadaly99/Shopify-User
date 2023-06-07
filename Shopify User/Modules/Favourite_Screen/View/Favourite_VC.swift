//
//  Favourite_VC.swift
//  Shopify User
//
//  Created by MAC on 07/06/2023.
//

import UIKit

class Favourite_VC: UIViewController {
    @IBOutlet weak var myTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTable.register(UINib(nibName: "Favourite_Cell", bundle: nil), forCellReuseIdentifier: "Favourite_Cell")
    }
    
}
extension Favourite_VC : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("hi")
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Favourite_Cell", for: indexPath) as!Favourite_Cell

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(110)
    }
}
