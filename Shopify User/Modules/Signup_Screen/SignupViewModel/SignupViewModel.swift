//
//  SignupViewModel.swift
//  Shopify User
//
//  Created by MAC on 08/06/2023.
//

import Foundation
import RxSwift
import RxCocoa
import RxRelay

class SignupViewModel{
    weak var delegate: ViewModelDelegate?

    let firstname = BehaviorRelay<String>(value: "")
    let lastname = BehaviorRelay<String>(value: "")
    let email = BehaviorRelay<String>(value: "")
    let password = BehaviorRelay<String>(value: "")
    let phone = BehaviorRelay<String>(value: "")
    let zip = BehaviorRelay<String>(value: "")
    let cityName = BehaviorRelay<String>(value: "")
    let countryName = BehaviorRelay<String>(value: "")
    
    var bindDataToView:(([Customer]) -> ()) = { _ in }
    var customersList: [Customer] = []{
      didSet{
          bindDataToView(self.customersList)
      }
    }
    
    func isValid(authManager:AuthenticationManager) -> Observable<Bool> {
        return Observable.combineLatest(firstname.asObservable(),lastname.asObservable(), email.asObservable(), password.asObservable(),phone.asObservable(),zip.asObservable(),cityName.asObservable(),countryName.asObservable())
            .map { firstname, lastname, email, password, phone, zip ,city ,country in
                
                let isValid = authManager.isEmailValid(email) &&                authManager.isUsernameValid(firstname) && authManager.isUsernameValid(lastname) && authManager.isPasswordValid(password)
                
                return !firstname.isEmpty && !lastname.isEmpty && !email.isEmpty && !password.isEmpty && !phone.isEmpty && !city.isEmpty && !zip.isEmpty && !country.isEmpty && isValid }
    }

    func getcustomers(){
      NetworkManager(url: "https://mad43-sv-ios3.myshopify.com/admin/api/2023-04/customers.json").fetchData{
          (result: RootCustomer?) in
          guard let items = result?.customers else{ return }
          self.customersList = items
      }
    }
    
    func signup() {
        print("signupFunc")
        getcustomers()
        var isExist = false
        var model = Customer()
        model.firstName = self.firstname.value
        model.lastName = self.lastname.value
        model.email = self.email.value
        model.tags = self.password.value
        bindDataToView =
        { mycustomers in
            //print("jjjj")
            for customer in mycustomers {
                
                if (model.email == customer.email) && (model.tags == customer.tags){
                    isExist = true
                    break
                }
            }
            if(isExist){
                print("User Already exist")
                self.delegate?.loginFailed()
            } else {
                Network.postMethod(url:"https://mad43-sv-ios3.myshopify.com/admin/api/2023-04/customers.json", model: model)
                { customer in
                    print("Post Responce :\(customer?.customer) ")
                    let defaults = UserDefaults.standard
                    defaults.set(customer?.customer?.firstName, forKey: Constants.KEY_USER_FIRSTNAME)
                    defaults.set(customer?.customer?.lastName, forKey: Constants.KEY_USER_LASTNAME)
                    defaults.set(Constants.USER_STATE_LOGIN, forKey: Constants.KEY_USER_STATE)
                    defaults.set(customer?.customer?.id, forKey: Constants.KEY_USER_ID)
                    if let customer_id = UserDefaults.standard.string(forKey: Constants.KEY_USER_ID) {
                        print("Welcome back, \(customer_id)!")
                    } else {
                        print("No username found.")
                    }
                    self.delegate?.didLoginSuccessfully()
                    print("reg done")
                }
                
            }
        }
    }
}
