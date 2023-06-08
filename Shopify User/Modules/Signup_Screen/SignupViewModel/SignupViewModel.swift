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
    let firstname = BehaviorRelay<String>(value: "")
    let lastname = BehaviorRelay<String>(value: "")
    let email = BehaviorRelay<String>(value: "")
    let password = BehaviorRelay<String>(value: "")
   
    let disposeBag = DisposeBag()

    var CustomerData :PublishSubject<RootCustomer> = PublishSubject()
    let reloadData = PublishSubject<Void>()
    let isLoading : PublishSubject<Bool> = PublishSubject()
    var isExist = false

    func getCustomers (url:String){
        isLoading.onNext(true)
        let url = URL(string: url)
        guard let urlFinal = url else { return }
        let request = URLRequest(url: urlFinal)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, responce, error in
            guard let data = data else{
                return
            }
            do{
                let result1 = try JSONDecoder().decode(RootCustomer.self, from: data)
                self.isLoading.onNext(false)
                self.CustomerData.onNext(result1)
                print ("Date : \(result1.customers[1].firstName)")

            }catch let error{
                print (error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func isValid(authManager:AuthenticationManager) -> Observable<Bool> {
        return Observable.combineLatest(firstname.asObservable(),lastname.asObservable(), email.asObservable(), password.asObservable())
            .map { firstname, lastname, email, password in
                
                let isValid = authManager.isEmailValid(email) &&                authManager.isUsernameValid(firstname) && authManager.isUsernameValid(lastname) && authManager.isPasswordValid(password)
                
                return !firstname.isEmpty && !lastname.isEmpty && !email.isEmpty && !password.isEmpty && isValid }
    }
    
    func checkIfUserExist(model:Customer){
        CustomerData.subscribe(onNext: { [weak self] customers in
            for customer in customers.customers {
                if (model.id == customer.id){
                    self?.isExist = true
                    break
                }
            }
        })
        .disposed(by: disposeBag)
    }
    
    func signup() {
        print("signupFunc")
        var model = Customer()
        model.firstName = self.firstname.value
        model.lastName = self.lastname.value
        model.email = self.email.value
        model.tags = self.password.value
       
        checkIfUserExist(model:model)

       // if(isValid){
            Network.postMethod(url:"https://mad43-sv-ios3.myshopify.com/admin/api/2023-04/customers.json", model: model)
            print("reg done")
            
       // } else {
            //print("faild to register")
       // }
    }
    
  
    
}
