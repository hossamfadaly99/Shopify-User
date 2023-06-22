//
//  LoginViewModel.swift
//  Shopify User
//
//  Created by MAC on 09/06/2023.
//

import Foundation
import RxSwift
import RxCocoa
import RxRelay

protocol ViewModelDelegate:AnyObject {
    func didLoginSuccessfully()
    func loginFailed()
}

class LoginViewModel{
    var bindCoreData: ()->() = {}
    var dataManager : DataManagerProtocol
    var networkManager: NetworkServiceProtocol
    var isEmptyList: Bool = true
    let defaults = UserDefaults.standard
    weak var delegate: ViewModelDelegate?
    let email = BehaviorRelay<String>(value: "")
    let password = BehaviorRelay<String>(value: "")
    var bindDataToView:(([Customer]) -> ()) = { _ in }
    var customersList: [Customer] = []{
      didSet{
          bindDataToView(self.customersList)
      }
    }
    var wishListArray: Draft_orders = Draft_orders(){
        didSet{
            bindCoreData()
        }
      }

    init( dataManager: DataManagerProtocol,networkManager: NetworkServiceProtocol) {
        self.dataManager = dataManager
        self.networkManager = networkManager
    }
    
    func fetchDataFromDB(user_ID:String)->[ProductCoreData]?{
       return
        dataManager.getStoredProducts(user_id: user_ID)
    }
    func deleteFromDB(product:ProductCoreData){
        dataManager.deleteFavProduct(myProduct:product)
    }
    
    func isExistIntoDB(product:ProductCoreData) -> Bool{
        return dataManager.isProductExist(myProduct:product)
    }
    func insertListIntoDB(products:[ProductCoreData]){
        dataManager.insertFavProducts(products: products, productRate: 2.5)
    }
    func isValid(authManager:AuthenticationManager) -> Observable<Bool> {
        return Observable.combineLatest(email.asObservable(), password.asObservable())
            .map { email, password in
                
                let isValid = authManager.isEmailValid(email) &&
                authManager.isPasswordValid(password)
                
                return !email.isEmpty && !password.isEmpty && isValid }
    }

    func getcustomers(){
        NetworkManager(url:URLCreator().getCustomersURL()).fetchData{
          (result: RootCustomer?) in
          guard let items = result?.customers else{ return }
          self.customersList = items
      }
    }
    
    func loadWishListItems(){
    guard let wishlist_id = UserDefaults.standard.string(forKey: Constants.USER_WISHLIST) else {return}
        networkManager.setURL(URLCreator().getEditCartURL(id: String(describing: wishlist_id)))
        networkManager.fetchData(compilitionHandler: { [weak self] (result: DraftOrderr?) in
            if let items = result?.draft_order?.line_items{
              if items.count == 1 && items.first?.title == "dummy" {
               // print("items a")
                print(items.count)
                  print(items.first?.title)
                self?.isEmptyList = true
                  self?.wishListArray = result?.draft_order ?? Draft_orders()
              }else {
                print("items b")
                print(items.count)
                  print(items.first?.title)
                self?.isEmptyList = false
                  self?.wishListArray = result?.draft_order ?? Draft_orders()
                  print("hjjjjjjjjjjjj\(items)")
              }
            }
          })
    }

    func setCDFromAPI(){
        loadWishListItems()
        bindCoreData = { [weak self] in
            var myDraft = self?.wishListArray
            var arr = myDraft?.line_items
            print("Count API Data : \(arr?.count)")
            let productsCD = Constants().mapLineItemsToProductCD(lineitems: arr ?? [])
            let coreData = self?.dataManager.insertFavProducts(products: productsCD, productRate: 3)
            
        }
    }
    func updateWishList (wishListItem: Draft_orders){
        guard let wishlist_id = UserDefaults.standard.string(forKey: Constants.USER_WISHLIST) else {return}
        print("Updated wishList ID:\(wishlist_id) ")
        networkManager.setURL(URLCreator().getEditCartURL(id: String(describing: wishlist_id)))
        networkManager.editItem(item: wishListItem, endPoint: "") { res in
            print ("result \(res)")
        }
    }
    
    func googleLogin(myModel:Customer){
        getcustomers()
        var isExist = false
        var model = myModel
        bindDataToView =
        { [self] mycustomers in
            for customer in mycustomers {
                if (model.email == customer.email) && (model.tags == customer.tags){
                    model = customer
                    isExist = true
                    break
                }
            }
            if(isExist){
                setUserDefaults(customer: model)
                seperate(complexSrt: model.note ?? "")
                print("login done")
                print("Model : \(model)")
                setCDFromAPI()
                self.delegate?.didLoginSuccessfully()
            } else {
                self.delegate?.loginFailed()
                print("not registered")
            }
        }
    }
    
    func login() {
        getcustomers()
        var isExist = false
        var model = Customer()
        model.email = self.email.value
        model.tags = self.password.value
        bindDataToView =
        { [self] mycustomers in
            for customer in mycustomers {
                if (model.email == customer.email) && (model.tags == customer.tags){
                    model = customer
                    isExist = true
                    break
                }
            }
            if(isExist){
                setUserDefaults(customer: model)
                seperate(complexSrt: model.note ?? "")
                print("login done")
                print("Model : \(model)")
                setCDFromAPI()
                self.delegate?.didLoginSuccessfully()
            } else {
                self.delegate?.loginFailed()
                print("not registered")
            }
        }
    }
    
    func seperate(complexSrt:String){
        let array = complexSrt.components(separatedBy: ",")
        defaults.set(array[0], forKey: Constants.USER_CART)
        defaults.set(array[1], forKey: Constants.USER_WISHLIST)
        print("ARRAY: \(array[0])")
    }
    
    func setUserDefaults(customer:Customer){
        defaults.set(customer.firstName, forKey: Constants.KEY_USER_FIRSTNAME)
        defaults.set(customer.lastName, forKey: Constants.KEY_USER_LASTNAME)
        defaults.set(customer.email, forKey: Constants.KEY_USER_EMAIL)
        defaults.set(Constants.USER_STATE_LOGIN, forKey: Constants.KEY_USER_STATE)
        defaults.set(customer.id, forKey: Constants.KEY_USER_ID)
        if let customer_id = UserDefaults.standard.string(forKey: Constants.KEY_USER_ID)
        {
            print("Welcome back, \(customer_id)!")
        } else {
            print("No username found.")
        }
    }
}
