//
//  Login_VC.swift
//  Shopify User
//
//  Created by MAC on 04/06/2023.
//

import UIKit
import RxSwift
import GoogleSignIn
import Firebase
import FirebaseAuth

class Login_VC: UIViewController {
    @IBOutlet weak var email_TF: UITextField!
    @IBOutlet weak var password_TF: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    
    var customer = Customer()
    let disposeBag = DisposeBag()
    var viewModel = LoginViewModel(dataManager: DataManager.sharedInstance,networkManager: NetworkManager(url: ""))
    var authManager = AuthenticationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        
        email_TF.addPaddingToTF()
        email_TF.layer.cornerRadius = 15.0
        email_TF.layer.borderWidth = 2.0
        email_TF.layer.borderColor = UIColor.lightGray.cgColor
        
        password_TF.addPaddingToTF()
        password_TF.layer.cornerRadius = 15.0
        password_TF.layer.borderWidth = 2.0
        password_TF.layer.borderColor = UIColor.lightGray.cgColor
        
        backBtn.rx.tap.asObservable().subscribe(onNext: { _ in
            let storyboard = UIStoryboard(name: "Signup_SB", bundle: nil)
            let nextViewController = storyboard.instantiateViewController(withIdentifier: Constants.SCREEN_ID_SIGNUP) as! Signup_VC
            nextViewController.modalPresentationStyle = .fullScreen
            self.present(nextViewController, animated: true, completion: nil)
        }).disposed(by: disposeBag)
        setupBindings()
        

    }
    
    @IBAction func enterAsGuest(_ sender: Any) {
        UserDefaults.standard.set(Constants.USER_STATE_GUEST, forKey: Constants.KEY_USER_STATE)
        let storyboard = UIStoryboard(name: "HomeStoryboard", bundle: nil)
        let nextViewController = storyboard.instantiateViewController(withIdentifier: Constants.SCREEN_ID_HOME)
        nextViewController.modalPresentationStyle = .fullScreen
        present(nextViewController, animated: true, completion: nil)
    }
    
    @IBAction func googleLogin(_ sender: Any) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
                
        let config = GIDConfiguration(clientID: clientID)

        GIDSignIn.sharedInstance.configuration = config
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
            if error != nil {
                print("error gooogle\(error?.localizedDescription)")

                   return
                }
                 print("hi gooogle")
            guard let signInResult = signInResult else { return }
                let user = signInResult.user
                let emailAddress = user.profile?.email
                let fullName = user.profile?.name
                let givenName = user.profile?.givenName
                let familyName = user.profile?.familyName

              //  let profilePicUrl = user.profile?.imageURL(withDimension: 320)
            var googleUser = Customer()
            googleUser.firstName = fullName ?? ""
            googleUser.lastName = familyName ?? ""
            googleUser.email = emailAddress ?? ""
            googleUser.tags = emailAddress ?? ""
            self.viewModel.googleLogin( myModel: googleUser)
          }
    }
    
    func setupBindings() {
        email_TF.rx.text.orEmpty
            .bind(to: viewModel.email)
            .disposed(by: disposeBag)
        
        password_TF.rx.text.orEmpty
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)

        loginBtn.rx.tap
                .subscribe(onNext: { [weak self] in
                    guard let self = self else { return }
                    if self.email_TF.text?.isEmpty == true || self.password_TF.text?.isEmpty == true {
                        AlertCreator.showAlert(title: "Alert", message: "Please fill in alh fields.", viewController: self)
                    } else {
                        self.viewModel.customer = self.customer
                        print("self.viewModel.customer \(self.viewModel.customer)")
                        self.viewModel.login()
                    }
                })
                .disposed(by: disposeBag)
    }

}

extension Login_VC:LoginViewModelDelegate{
    func loginSuccessfully() {
        let storyboard = UIStoryboard(name: "HomeStoryboard", bundle: nil)
        let nextViewController = storyboard.instantiateViewController(withIdentifier: Constants.SCREEN_ID_HOME)
        nextViewController.modalPresentationStyle = .fullScreen
        present(nextViewController, animated: true, completion: nil)
    }
    
    func googleLoginSuccessfully() {
        let storyboard = UIStoryboard(name: "HomeStoryboard", bundle: nil)
        let nextViewController = storyboard.instantiateViewController(withIdentifier: Constants.SCREEN_ID_HOME)
        nextViewController.modalPresentationStyle = .fullScreen
        present(nextViewController, animated: true, completion: nil)
    }
        
    func loginFailed() {
        print("failed to login")
        AlertCreator.showAlert(title: "Alert", message: "Please enter right data.", viewController: self)
    }

    func userNotVerified(user : User) {
        print("verification not compeleted\(user)")
        let alertController = UIAlertController(title: "Verification", message: "Your E-Mail isn't verified you can check your mails to verify,or If you clicked resend we will send new verification mail but you have to wait 10 mins", preferredStyle: .alert)
        let signUpAction = UIAlertAction(title: "resend", style: .default) { _ in
         
            user.sendEmailVerification { error in
                if let error = error {
                    // Handle the error
                    print("Error sending email verification: \(error.localizedDescription)")
                    return
                }
                print("Email verification sent successfully")
            }
        }
        let noAction = UIAlertAction(title: "ok", style: .default ,handler: nil)
        
        alertController.addAction(signUpAction)
        alertController.addAction(noAction)
        present(alertController, animated: true, completion: nil)
    }
    
}

