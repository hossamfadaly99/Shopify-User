//
//  Favourite_VC.swift
//  Shopify User
//
//  Created by MAC on 08/06/2023.
//

import UIKit

class Favourite_VC: UIViewController ,ReloadTableViewDelegate{
    
    @IBOutlet weak var noItemImg: UIImageView!
    
    @IBOutlet weak var mytable: UITableView!
    var viewModel : FavouritViewModel!
    var favourieList:[ProductCoreData]?=[]
    var customer_id = UserDefaults.standard.string(forKey: Constants.KEY_USER_ID)
    let favViewModel = ProductsDetailsViewModel(networkManager: NetworkManager(url: ""),dataManager: DataManager.sharedInstance)

    override func viewDidLoad() {
        super.viewDidLoad()
      //  self.navigationController?.navigationBar.isHidden = true
        mytable.register(UINib(nibName: Constants.CELL_ID_FAVOURITE, bundle: nil), forCellReuseIdentifier: Constants.CELL_ID_FAVOURITE)
        viewModel = FavouritViewModel(dataManager: DataManager.sharedInstance)
        favourieList = viewModel?.fetchDataFromDB(user_ID: customer_id ?? "") ?? []
        mytable.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        favourieList = viewModel?.fetchDataFromDB(user_ID: customer_id ?? "") ?? []
        mytable.reloadData()
        hideFavouritesImage(list: favourieList ?? [], img: noItemImg)

     }
    
    @IBAction func backBtn(_ sender: Any) {
        print("'baccccck'")
        dismiss(animated: true ,completion: nil)
    }
    
}



extension Favourite_VC : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("hi")
        return favourieList?.count ?? 0
    }
    
    func hideFavouritesImage(list:[ProductCoreData],img:UIImageView){
        if list.count != 0{
            noItemImg.isHidden = true
        } else {
            noItemImg.isHidden = false
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Fav_Cell", for: indexPath) as!Fav_Cell
        cell.img?.kf.setImage(with:URL(string: favourieList?[indexPath.row].Pimage ?? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQB3yIFU8Dx5iqV6fxsmrxvzkDYbgQaxIp19SRyR9DQ&s") )
        cell.PName.text = favourieList?[indexPath.row].title ?? "Title"
        cell.pPrice.text = favourieList?[indexPath.row].price ?? "00.00"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(140)
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "ProductDetails_SB", bundle: nil) // Replace "Main" with your storyboard name
        let nextViewController = storyboard.instantiateViewController(withIdentifier: Constants.SCREEN_ID_PRODUCTSDETAILS) as! ProductDetails_VC
        //nextViewController.modalPresentationStyle = .fullScreen
        nextViewController.ID_Product_VC = favourieList?[indexPath.row].id
        nextViewController.favTableViewController = self
        present(nextViewController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {

            let alert = UIAlertController(title: "Deletion Alert", message: "Are you sure you want to delete this item?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: {_ in
                self.favViewModel.bindCartData = { [weak self] in
                    var myDraft = self?.favViewModel.wishListArray
                    var arr = myDraft?.line_items
                    guard var arr = arr else {return }
                    print("Array before deletion \(arr)")
                    var myId = self?.favourieList?[indexPath.row].id
                    print("myId = \(myId)")

                    for i in 0..<arr.count {
                        var apiId = arr[i].product_id
                        print("apiId = \(apiId)")
                        if (apiId == myId){
                            arr.remove(at: i)
                            self?.viewModel.deleteFromDB(product: (self?.favourieList?[indexPath.row])!)
                            self?.favourieList?.remove(at: indexPath.row)
                            tableView.reloadData()
                            break
                        }
                    }
                    print("Array after deletion \(arr)")
                    myDraft?.line_items = arr
                    self?.favViewModel.updateWishList(wishListItem: myDraft ?? Draft_orders())
                }
                self.favViewModel.loadWishListItems()
                self.hideFavouritesImage(list: self.favourieList ?? [], img: self.noItemImg)
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
               present(alert, animated: true, completion: nil)
        }
    }
    
    func reloadTableView() {
        mytable.reloadData()
    }
}
