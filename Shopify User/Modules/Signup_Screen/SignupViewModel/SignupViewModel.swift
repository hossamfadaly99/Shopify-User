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
import FirebaseAuth

protocol SignUpDelegate:AnyObject {
    func googleSignUpSuccessfully()
    func signUpSuccessfully()
    func SignUpFailed()
   // func userNotVerified(user : User)
}

class SignupViewModel{
    
    let group = DispatchGroup()
    let firebaseGroup = DispatchGroup()
    weak var delegate: SignUpDelegate?
    let defaults = UserDefaults.standard
    let firstname = BehaviorRelay<String>(value: "")
    let lastname = BehaviorRelay<String>(value: "")
    let email = BehaviorRelay<String>(value: "")
    let password = BehaviorRelay<String>(value: "")
    
    var bindDataToView:(([Customer]) -> ()) = { _ in }
    var customersList: [Customer] = []{
        didSet{
            bindDataToView(self.customersList)
        }
    }
    
    func getcustomers(){
        NetworkManager(url:URLCreator().getCustomersURL()).fetchData{
            (result: RootCustomer?) in
            guard let items = result?.customers else{ return }
            self.customersList = items
        }
    }
    
    func googleSignUp(model:Customer){
        getcustomers()
        print("googleSignUp")
        var isExist = false
        bindDataToView =
        { mycustomers in
            for customer in mycustomers {
                if (model.email == customer.email) && (model.tags == customer.tags){
                    isExist = true
                    break
                }
            }
            if(isExist){
                self.delegate?.SignUpFailed()
            } else {
                Network.postMethod(url:URLCreator().getCustomersURL(), model: model)
                { customer in
                    guard let singleCustomer = customer?.customer else{return}
                    print("nuuuuuu:\(singleCustomer)")
                    self.setUserDefaults(customer: singleCustomer)
                    
                    self.group.enter()
                    self.cresteWishList(mycustomer: singleCustomer)
                    
                    self.group.enter()
                    self.createCart(mycustomer: singleCustomer)
                    
                    self.group.notify(queue: .global()){
                        self.assignWishListToUser( mycustomer: singleCustomer)
                        OperationQueue.main.addOperation{
                            self.delegate?.googleSignUpSuccessfully()
                            
                        }
                    }
                    print("reg done")
                }
                
            }
        }
    }
    func signup() {
         getcustomers()
         var isExist = false
         var model = Customer()
         model.firstName = self.firstname.value
         model.lastName = self.lastname.value
         model.email = self.email.value
         model.tags = self.password.value
         bindDataToView =
         { mycustomers in
             for customer in mycustomers {
                 if (model.email == customer.email) && (model.tags == customer.tags){
                     isExist = true
                     break
                 }
             }
             if(isExist){
                 self.delegate?.SignUpFailed()
             } else {
                 print("creating Custttttomerr")

                 Network.postMethod(url:URLCreator().getCustomersURL(), model: model)
                 { customer in
                     print("creatinnnnnnnnnn")

                     guard let singleCustomer = customer?.customer else{return}
                     //   print("nuuu:\(singleCustomer)")
                     self.setUserDefaults(customer: singleCustomer)

                     self.group.enter()
                     self.cresteWishList(mycustomer: singleCustomer)

                     self.group.enter()
                     self.createCart(mycustomer: singleCustomer)

                     self.group.notify(queue: .global()){
                         self.assignWishListToUser( mycustomer: singleCustomer)
                     }
                     print("reg done")
                    // self.firebaseGroup.leave()
                 }
                 Auth.auth().createUser(withEmail: model.email ?? "", password: model.tags ?? "") { authResult, error in
                     if let error = error {
                         print("Error creating user: \(error.localizedDescription)")
                         return
                     }
                     print("creating User and send mail")
                         guard let user = authResult?.user else{return}
                         user.sendEmailVerification { error in
                             if let error = error {
                                 // Handle the error
                                 print("Error sending email verification: \(error.localizedDescription)")
                                 return
                             }
                             print("Email verification sent successfully")
                             self.delegate?.signUpSuccessfully()
                         }
                   //  }
                 }

             }
         }
     }

    
//    func checkIfUserVerfied() -> Bool{
//        var isVerified = false
//
//        if let user = Auth.auth().currentUser {
//            // User is signed in
//            // Check if the user's email is verified
//            if user.isEmailVerified {
//                // User's email is verified
//                print("User's email is verified")
//                isVerified = true
//            } else {
//                // User's email is not verified
//                print("User's email is not verified")
//                isVerified = false
//            }
//        } else {
//            // No user is signed in
//            print("No user is signed in")
//        }
//       // self.firebaseGroup.leave()
//        return isVerified
//    }
//    func sendMailVerfication(authResult: AuthDataResult?) -> Bool{
//        var isMailSent = false
//        guard let user = authResult?.user else{return false}
//            // The user is created and signed in automatically
//            print("User created successfully: \(user.uid)")
//            user.sendEmailVerification { error in
//                if let error = error {
//                    // Handle the error
//                    print("Error sending email verification: \(error.localizedDescription)")
//                    isMailSent = false
//                }
//                print("Email verification sent successfully")
//                isMailSent = true
//
//            }
//        //self.firebaseGroup.leave()
//        return isMailSent
//    }
    
     func setUserDefaults(customer:Customer){
         defaults.set(customer.firstName, forKey: Constants.KEY_USER_FIRSTNAME)
         defaults.set(customer.lastName, forKey: Constants.KEY_USER_LASTNAME)
         defaults.set(customer.email, forKey: Constants.KEY_USER_EMAIL)
         defaults.set(Constants.USER_STATE_LOGIN, forKey: Constants.KEY_USER_STATE)
         defaults.set(customer.id, forKey: Constants.KEY_USER_ID)
         if let customer_id = UserDefaults.standard.string(forKey: Constants.KEY_USER_ID)
         {
             print("Customer ID : \(customer_id)!")
         } else {
             print("No username found.")
         }
     }
     func cresteWishList(mycustomer:Customer){
         var myModel = MyDraftOrders()
         myModel.note = "MyWishList"
         myModel.customer?.id = mycustomer.id
         Network.createDraftOrder(endPoint: URLCreator().getCreateCartURL(), model: myModel) { draftOrder in 
             guard let myWishList = draftOrder?.draft_order else {return}
            // self.assignWishListToUser(whishList: myWishList, mycustomer: mycustomer)
             self.defaults.set(myWishList.id, forKey: Constants.USER_WISHLIST)
             guard let wishlist_id = UserDefaults.standard.string(forKey: Constants.USER_WISHLIST) else {return}
          //   print("result wish\(myWishList)")
             print("vvv:\(wishlist_id)")
             
             self.group.leave()
         }
     }
     func createCart(mycustomer:Customer){
         var myModel = MyDraftOrders()
         myModel.note = "MyCart"
         myModel.customer?.id = mycustomer.id
         Network.createDraftOrder(endPoint: URLCreator().getCreateCartURL(), model: myModel) { draftOrder in
             guard let myCart = draftOrder?.draft_order else {return}
             self.defaults.set(myCart.id, forKey: Constants.USER_CART)
             guard let cart = UserDefaults.standard.string(forKey: Constants.USER_CART) else {return}
          //   print("result cart\(myCart)")
             print("sss:\(cart)")
             self.group.leave()
         }
     }
    
    func assignWishListToUser(mycustomer:Customer){
       // print ("welcome assign")
        guard let cart_id = UserDefaults.standard.string(forKey: Constants.USER_CART) else{return}
        guard let wishlist_id = UserDefaults.standard.string(forKey: Constants.USER_WISHLIST) else {return}
     //   print ("\(cart_id),Hollooooo,\(wishlist_id)")
        var customer = mycustomer
        customer.note = "\(cart_id),\(wishlist_id)"
        let note = customer.note
        print("Nottte : \(note)")
    //    print("note : \(customer.note)")
        print("userdefa : \(wishlist_id)")
        
     //   print("AAAAAAAAAAAAA : \(customer)")
       print("Updated Customer note : \(customer)")
        Network.updateCustomer(url: URLCreator().getCustomer(customer_id: String(mycustomer.id ?? 0)), model: customer) { response in
      //      print("Updated Customer : \(response)")
        }
    }
    
}

 

// self.firebaseGroup.enter()
// let isSent = self.sendMailVerfication(authResult: authResult)
 
//   self.group.notify(queue: .global()){
   //  if(isSent){
        // self.firebaseGroup.enter()
//                             let isVerified = self.checkIfUserVerfied()
//
//                             if(isVerified){
//                                 print("isVeriied true")
//                                 self.createAPICustomer(model: model)
//                             }else{
//                                 OperationQueue.main.addOperation{
//                                     self.delegate?.userNotVerified()
//                                 }
//                             }
         
         
//                         } else {
//                             print("Mail send error")
//                         }
//                     }
