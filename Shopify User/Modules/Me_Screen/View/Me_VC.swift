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
    
    @IBOutlet weak var guestView: UIView!
    
    var viewModel : FavouritViewModel!
    var orderViewModel : OrderViewModel!
    var favourieList:[ProductCoreData] = []
    var orderList:[Order] = []
    //var twoFav:[ProductCoreData]?=[]
    var customer_Name = UserDefaults.standard.string(forKey: Constants.KEY_USER_FIRSTNAME)
    var customer_id = UserDefaults.standard.string(forKey: Constants.KEY_USER_ID)

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let state = UserDefaults.standard.string(forKey: Constants.KEY_USER_STATE) else{return}
        if(state == Constants.USER_STATE_GUEST){
            guestView.isHidden = false
        } else {
            guestView.isHidden = true
            
            favsTable.delegate = self
            favsTable.dataSource = self
            ordersTable.delegate = self
            ordersTable.dataSource = self
            guard let customer_Name = customer_Name else {return}
            WelcomeLabel.text = "Welcome \(customer_Name)"
            
            favsTable.register(UINib(nibName: Constants.CELL_ID_FAVOURITE, bundle: nil), forCellReuseIdentifier: Constants.CELL_ID_FAVOURITE)
            
            let  nib = UINib(nibName: "OrderCustomCell", bundle: nil)
            ordersTable.register(nib, forCellReuseIdentifier: "order")
            viewModel = FavouritViewModel(dataManager: DataManager.sharedInstance)
            favourieList = viewModel?.fetchDataFromDB(user_ID: customer_id ?? "" ) ?? []
        }
    }
    
    func setupViewModel(){
        
        orderViewModel = OrderViewModel()
        orderViewModel?.CustomerID = "\(storedCustomerId)"
        orderViewModel?.getItems()
        orderViewModel?.bindResultToViewController={
            [weak self] in
            self?.orderList = self?.orderViewModel?.result ?? []
            DispatchQueue.main.async {
                print(self?.orderList.count)
                self?.checkOrderList()
                self?.ordersTable.reloadData()
            }
        }
        
    }
    
    @IBAction func navigateToSign(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Signup_SB", bundle: nil)
        let nextViewController = storyboard.instantiateViewController(withIdentifier: Constants.SCREEN_ID_SIGNUP) as! Signup_VC
        nextViewController.modalPresentationStyle = .fullScreen
        present(nextViewController, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let state = UserDefaults.standard.string(forKey: Constants.KEY_USER_STATE) else{return}
        if(state == Constants.USER_STATE_GUEST){
            guestView.isHidden = false
        } else {
            guestView.isHidden = true

            //  favourieList = viewModel?.fetchDataFromDB(user_ID: customer_Name ?? "") ?? []
            //ordersTable.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
            
            favourieList = viewModel?.fetchDataFromDB(user_ID: customer_id ?? "" ) ?? []
            setupViewModel()
            favsTable.reloadData()
            checkFav()
            favsTable.reloadData()
            checkOrderList()
            ordersTable.reloadData()
            // hideFavouritesImage(list: favourieList ?? [], img: noItemImg)
        }
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
                height.constant = 160
            }
        } else {
            favsTable.isHidden = false
            if let height = favsTable.constraints.first(where: { $0.firstAttribute == .height }){
                height.constant = 320
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
                height.constant = 160
            }
        } else {
            ordersTable.isHidden = false
            if let height = ordersTable.constraints.first(where: { $0.firstAttribute == .height }){
                height.constant = 320
            }
        }
    }
    
    
    @IBAction func seeMoreOrders(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "HomeStoryboard", bundle: nil)
        let nextViewController = storyboard.instantiateViewController(withIdentifier: "allOrder") as! OrderViewController
        nextViewController.modalPresentationStyle = .fullScreen
        present(nextViewController, animated: true, completion: nil)
    }
    
    @IBAction func NavigateToCart(_ sender: Any) {
    }
    
    
    
    @IBAction func seeMoreFavs(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Favourite_SB", bundle: nil)
        let nextViewController = storyboard.instantiateViewController(withIdentifier: Constants.SCREEN_ID_FAVOURITE) as! Favourite_VC
       nextViewController.modalPresentationStyle = .fullScreen
        present(nextViewController, animated: true, completion: nil)
        
    }
    
    
    @IBAction func goToSettings(_ sender: Any) {
        let storyboard = UIStoryboard(name: "SettingsStoryboard", bundle: nil)
        let nextViewController = storyboard.instantiateViewController(withIdentifier: "SettingsTableViewController") as! SettingsTableViewController
//      nextViewController.modalPresentationStyle = 
        present(nextViewController, animated: true, completion: nil)
    }
    
}

extension Me_VC :UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView ==  favsTable {
          
            return min(2,favourieList.count)
        } else if tableView == ordersTable {
            return min(2,orderList.count)
        }else{
            return 0
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView ==  favsTable {
            return CGFloat(140)
        }else{
            return CGFloat(180)
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("cellforrow")
        if tableView ==  favsTable {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Fav_Cell", for: indexPath) as!Fav_Cell
            cell.img?.kf.setImage(with:URL(string: favourieList[indexPath.row].Pimage ?? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQB3yIFU8Dx5iqV6fxsmrxvzkDYbgQaxIp19SRyR9DQ&s") )
            cell.PName.text = favourieList[indexPath.row].title ?? "Title"
            cell.pPrice.text = favourieList[indexPath.row].price ?? "00.00"
            cell.contentView.frame = cell.PName.frame.inset(by: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4))
            cell.contentView.layer.borderWidth = 2
            cell.contentView.layer.borderColor = UIColor.black.cgColor
            cell.contentView.layer.cornerRadius = 25
            print("hhhhhhhhhjhuhhohhohohuoho")
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "order", for: indexPath) as! OrderCustomCell
            cell.orderIdLabel.text = "\(orderList[indexPath.row].id ?? 0)"
            cell.orderDateLabel.text = orderList[indexPath.row].createdAt
            cell.orderTotalPriceLabel.text = orderList[indexPath.row].currentTotalPrice
            
            cell.contentView.frame = cell.orderIdLabel.frame.inset(by: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4))
            cell.contentView.layer.borderWidth = 2
            cell.contentView.layer.borderColor = UIColor.black.cgColor
            cell.contentView.layer.cornerRadius = 25
            
            cell.contentView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
            
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
