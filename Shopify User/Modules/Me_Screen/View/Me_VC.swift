//
//  Me_VC.swift
//  Shopify User
//
//  Created by MAC on 19/06/2023.
//

import UIKit

class Me_VC: UIViewController {
    @IBOutlet weak var WelcomeLabel: UILabel!
    @IBOutlet weak var ordersTable: UITableView!
   
    @IBOutlet weak var favsTable: UITableView!
    
    @IBOutlet weak var favsView: UIView!
    
    @IBOutlet weak var orderView: UIView!
    
    var viewModel : FavouritViewModel!
    var favourieList:[ProductCoreData] = []
    var orderList:[String] = []
    //var twoFav:[ProductCoreData]?=[]
    var customer_Name = UserDefaults.standard.string(forKey: Constants.KEY_USER_FIRSTNAME)
    var customer_id = UserDefaults.standard.string(forKey: Constants.KEY_USER_ID)

    override func viewDidLoad() {
        super.viewDidLoad()
        favsTable.delegate = self
        favsTable.dataSource = self
        ordersTable.delegate = self
        ordersTable.dataSource = self
        guard let customer_Name = customer_Name else {return}
        WelcomeLabel.text = "Welcome \(customer_Name)"
        
        favsTable.register(UINib(nibName: Constants.CELL_ID_FAVOURITE, bundle: nil), forCellReuseIdentifier: Constants.CELL_ID_FAVOURITE)
        viewModel = FavouritViewModel(dataManager: DataManager.sharedInstance)
      
        favourieList = viewModel?.fetchDataFromDB(user_ID: customer_id ?? "" ) ?? []
        
//        if (favourieList?.count == 0){
//            favouritesTable.isHidden = true
//        }
//favsTable.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
      //  favourieList = viewModel?.fetchDataFromDB(user_ID: customer_Name ?? "") ?? []
        favourieList = viewModel?.fetchDataFromDB(user_ID: customer_id ?? "" ) ?? []
        favsTable.reloadData()
        checkFav()
        checkOrderList()
        favsTable.reloadData()
        ordersTable.reloadData()
       // hideFavouritesImage(list: favourieList ?? [], img: noItemImg)
        
     }
    func checkFav(){
        if(favourieList.isEmpty){
            favsTable.isHidden = true
            if let height = favsTable.constraints.first(where: { $0.firstAttribute == .height }){
                height.constant = 0
            }
            
        }else if (favourieList.count == 1){
            favsTable.isHidden = false
            if let height = favsTable.constraints.first(where: { $0.firstAttribute == .height }){
                height.constant = 145
            }
        } else {
            favsTable.isHidden = false
            if let height = favsTable.constraints.first(where: { $0.firstAttribute == .height }){
                height.constant = 290
            }
        }
    }
    func checkOrderList(){
        if(orderList.isEmpty){
            ordersTable.isHidden = true
            if let height = ordersTable.constraints.first(where: { $0.firstAttribute == .height }){
                height.constant = 0
            }
            
        }else if (orderList.count == 1){
            ordersTable.isHidden = false
            if let height = ordersTable.constraints.first(where: { $0.firstAttribute == .height }){
                height.constant = 145
            }
        } else {
            ordersTable.isHidden = false
            if let height = ordersTable.constraints.first(where: { $0.firstAttribute == .height }){
                height.constant = 290
            }
        }
    }
    
    
    @IBAction func seeMoreOrders(_ sender: Any) {
    }
    
    @IBAction func seeMoreFavs(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Favourite_SB", bundle: nil)
        let nextViewController = storyboard.instantiateViewController(withIdentifier: Constants.SCREEN_ID_FAVOURITE) as! Favourite_VC
       nextViewController.modalPresentationStyle = .fullScreen
        present(nextViewController, animated: true, completion: nil)
   
    }
    
    
    @IBAction func goToSettings(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        let nextViewController = storyboard.instantiateViewController(withIdentifier: Constants.SCREEN_ID_PROFILE) as! Profile_VC
       nextViewController.modalPresentationStyle = .fullScreen
        present(nextViewController, animated: true, completion: nil)
    }
    
}

extension Me_VC :UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView ==  favsTable {
          
            return min(2,favourieList.count)
        } else {
            return orderList.count
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(140)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("cellforrow")
        if tableView ==  favsTable {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Fav_Cell", for: indexPath) as!Fav_Cell
            cell.img?.kf.setImage(with:URL(string: favourieList[indexPath.row].Pimage ?? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQB3yIFU8Dx5iqV6fxsmrxvzkDYbgQaxIp19SRyR9DQ&s") )
            cell.PName.text = favourieList[indexPath.row].title ?? "Title"
            cell.pPrice.text = favourieList[indexPath.row].price ?? "00.00"
            print("hhhhhhhhhjhuhhohhohohuoho")
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Fav_Cell", for: indexPath) as!Fav_Cell
            
            return cell
            
        }
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView ==  favsTable {
            let storyboard = UIStoryboard(name: "ProductDetails_SB", bundle: nil) // Replace "Main" with your storyboard name
            let nextViewController = storyboard.instantiateViewController(withIdentifier: Constants.SCREEN_ID_PRODUCTSDETAILS) as! ProductDetails_VC
            //nextViewController.modalPresentationStyle = .fullScreen
            nextViewController.ID_Product_VC = favourieList[indexPath.row].id
            present(nextViewController, animated: true, completion: nil)
        }
    }
}
