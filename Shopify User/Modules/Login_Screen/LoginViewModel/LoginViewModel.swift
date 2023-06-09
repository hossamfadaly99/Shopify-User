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


class LoginViewModel{
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
      NetworkManager(url: "https://mad43-sv-ios3.myshopify.com/admin/api/2023-04/customers.json").fetchData{
          (result: MyCustomer?) in
          guard let items = result?.customers else{ return }
          self.customersList = items
      }
    }
    
    func login() {
        print("signupFunc")
        getcustomers()
        var isExist = false
        var model = Customer()
        model.email = self.email.value
        model.tags = self.password.value
        bindDataToView =
        { mycustomers in
            print("jjjj")
            for customer in mycustomers {
                
                if (model.email == customer.email) && (model.tags == customer.tags){
                    model = customer
                    isExist = true
                    break
                }
            }
            if(isExist){
                let defaults = UserDefaults.standard
                defaults.set(model.first_name, forKey: Constants.KEY_USER_FIRSTNAME)
                defaults.set(model.last_name, forKey: Constants.KEY_USER_LASTNAME)
                defaults.set(Constants.USER_STATE_LOGIN, forKey: Constants.KEY_USER_STATE)
                print("login done")
            } else {
                print("not registered")
            }
        }
    }
}