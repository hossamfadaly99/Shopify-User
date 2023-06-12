//
//  Favourite_VC.swift
//  Shopify User
//
//  Created by MAC on 08/06/2023.
//

import UIKit

class Favourite_VC: UIViewController {

    @IBOutlet weak var mytable: UITableView!
    var viewModel : FavouritViewModel!
    var favourieList:[NadaProduct]?=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mytable.register(UINib(nibName: Constants.CELL_ID_FAVOURITE, bundle: nil), forCellReuseIdentifier: Constants.CELL_ID_FAVOURITE)
        viewModel = FavouritViewModel(dataManager: DataManager.sharedInstance)
        favourieList = viewModel?.fetchDataFromDB() ?? []
        mytable.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {

        if(viewModel?.fetchDataFromDB()?.count != 0){
            favourieList = viewModel?.fetchDataFromDB() ?? []
            mytable.reloadData()
         //Lottie.isHidden = true
        }else{
            //Lottie.isHidden = false
        }
     }
    
}
extension Favourite_VC : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("hi")
        return favourieList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Favourite_Cell", for: indexPath) as!Favourite_Cell
        //cell.imgBG.layer.cornerRadius = 9
       // print(favourieList?[indexPath.row].images?[0].src)
        cell.pImg?.kf.setImage(with:URL(string: favourieList?[indexPath.row].Pimage ?? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQB3yIFU8Dx5iqV6fxsmrxvzkDYbgQaxIp19SRyR9DQ&s") )
        cell.pName.text = favourieList?[indexPath.row].title ?? "Title"
        cell.pPrice.text = favourieList?[indexPath.row].price ?? "00.00"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(120
        )
    }
}
