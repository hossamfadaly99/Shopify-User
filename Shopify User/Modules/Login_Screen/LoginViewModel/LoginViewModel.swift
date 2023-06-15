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
    
    weak var delegate: ViewModelDelegate?
    
    let email = BehaviorRelay<String>(value: "")
    let password = BehaviorRelay<String>(value: "")
    var bindDataToView:(([Customer]) -> ()) = { _ in }
    var customersList: [Customer] = []{
      didSet{
          bindDataToView(self.customersList)
      }
    }
    
    func isValid(authManager:AuthenticationManager) -> Observable<Bool> {
        return Observable.combineLatest(email.asObservable(), password.asObservable())
            .map { email, password in
                
                let isValid = authManager.isEmailValid(email) &&                 authManager.isPasswordValid(password)
                
                return !email.isEmpty && !password.isEmpty && isValid }
    }

    func getcustomers(){
        NetworkManager(url:URLCreator().getCustomersURL()).fetchData{
          (result: RootCustomer?) in
          guard let items = result?.customers else{ return }
          self.customersList = items
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
                let defaults = UserDefaults.standard
                defaults.set(model.firstName, forKey: Constants.KEY_USER_FIRSTNAME)
                defaults.set(model.lastName, forKey: Constants.KEY_USER_LASTNAME)
                defaults.set(model.email, forKey: Constants.KEY_USER_EMAIL)
                defaults.set(Constants.USER_STATE_LOGIN, forKey: Constants.KEY_USER_STATE)
                defaults.set(model.id, forKey: Constants.KEY_USER_ID)
                if let customer_id = UserDefaults.standard.string(forKey: Constants.KEY_USER_ID) {
                    print("Welcome back, \(customer_id)!")
                } else {
                    print("No username found.")
                }
                print("login done")
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
                let defaults = UserDefaults.standard
                defaults.set(model.firstName, forKey: Constants.KEY_USER_FIRSTNAME)
                defaults.set(model.lastName, forKey: Constants.KEY_USER_LASTNAME)
                defaults.set(model.email, forKey: Constants.KEY_USER_EMAIL)

                defaults.set(Constants.USER_STATE_LOGIN, forKey: Constants.KEY_USER_STATE)
                defaults.set(model.id, forKey: Constants.KEY_USER_ID)
                if let customer_id = UserDefaults.standard.string(forKey: Constants.KEY_USER_ID) {
                    print("Welcome back, \(customer_id)!")
                } else {
                    print("No username found.")
                }
                print("login done")
                self.delegate?.didLoginSuccessfully()
            } else {
                self.delegate?.loginFailed()
                print("not registered")
            }
        }
    }
}
