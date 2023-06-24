//
//  Signup_VC.swift
//  Shopify User
//
//  Created by MAC on 04/06/2023.
//

import UIKit
import RxSwift
import GoogleSignIn
import Firebase
import FirebaseAuth

class Signup_VC: UIViewController {
    @IBOutlet weak var email_TF: UITextField!
    @IBOutlet weak var firstName_TF: UITextField!
    @IBOutlet weak var lastName_TF: UITextField!
    @IBOutlet weak var password_TF: UITextField!
    @IBOutlet weak var signupBtn: UIButton!
    
    let disposeBag = DisposeBag()
    var viewModel = SignupViewModel()
    var authManager = AuthenticationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        email_TF.addPaddingToTF()
        email_TF.layer.cornerRadius = 15.0
        email_TF.layer.borderWidth = 2.0
        email_TF.layer.borderColor = UIColor.lightGray.cgColor
        
        firstName_TF.addPaddingToTF()
        firstName_TF.layer.cornerRadius = 15.0
        firstName_TF.layer.borderWidth = 2.0
        firstName_TF.layer.borderColor = UIColor.lightGray.cgColor
        
        lastName_TF.addPaddingToTF()
        lastName_TF.layer.cornerRadius = 15.0
        lastName_TF.layer.borderWidth = 2.0
        lastName_TF.layer.borderColor = UIColor.lightGray.cgColor
        
        password_TF.addPaddingToTF()
        password_TF.layer.cornerRadius = 15.0
        password_TF.layer.borderWidth = 2.0
        password_TF.layer.borderColor = UIColor.lightGray.cgColor
        
        setupBindings()
    }
    
    @IBAction func signWithGoogle(_ sender: Any) {
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
            self.viewModel.googleSignUp(model: googleUser)
          }
    }
    
    @IBAction func navigate(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Login_SB", bundle: nil)
        let nextViewController = storyboard.instantiateViewController(withIdentifier: Constants.SCREEN_ID_LOGIN) as! Login_VC
        nextViewController.modalPresentationStyle = .fullScreen
        present(nextViewController, animated: true, completion: nil)

    }
    
    func setupBindings() {
        firstName_TF.rx.text.orEmpty
            .bind(to: viewModel.firstname)
            .disposed(by: disposeBag)
        
        lastName_TF.rx.text.orEmpty
            .bind(to: viewModel.lastname)
            .disposed(by: disposeBag)
        
        email_TF.rx.text.orEmpty
            .bind(to: viewModel.email)
            .disposed(by: disposeBag)
        
        password_TF.rx.text.orEmpty
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)
        
        firstName_TF.rx.controlEvent([.editingDidEnd])
            .subscribe(onNext: { [weak self] in
                self?.validateText(textField: (self?.firstName_TF)!)
            })
            .disposed(by: disposeBag)
        
        lastName_TF.rx.controlEvent([.editingDidEnd])
            .subscribe(onNext: { [weak self] in
                self?.validateText(textField:(self?.lastName_TF)!)
            })
            .disposed(by: disposeBag)
        
        email_TF.rx.controlEvent([.editingDidEnd])
            .subscribe(onNext: { [weak self] in
                self?.validateEmail()
            })
            .disposed(by: disposeBag)
        
        password_TF.rx.controlEvent([.editingDidEnd])
            .subscribe(onNext: { [weak self] in
                self?.validatePassword()
            })
            .disposed(by: disposeBag)
        
        signupBtn.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                if self.email_TF.text?.isEmpty == true || self.password_TF.text?.isEmpty == true
                    || self.firstName_TF.text?.isEmpty == true || self.lastName_TF.text?.isEmpty == true
                {
                    AlertCreator.showAlert(title: "Alert", message: "Please fill in alh fields.", viewController: self)
                } else {
                    if  self.authManager.isUsernameValid(self.firstName_TF.text!) &&
                        self.authManager.isUsernameValid(self.lastName_TF.text!) &&
                        self.authManager.isPasswordValid(self.password_TF.text!) &&
                        self.authManager.isEmailValid(self.email_TF.text!)
                    {
                        self.viewModel.signup()
                    }else {
                        AlertCreator.showAlert(title: "Unvalid Data Alert", message: "Please check your fields", viewController: self)
                    }
                }
            })
            .disposed(by: disposeBag)
    }
    
    func validateText(textField :UITextField) {
            guard let text = textField.text else { return }
            
        if authManager.isUsernameValid(text) {
                textField.layer.borderColor = UIColor.lightGray.cgColor
            } else {
                textField.layer.borderColor = UIColor.red.cgColor
            }
    }
    func validatePassword() {
            guard let text = password_TF.text else { return }
            
        if authManager.isPasswordValid(text) {
                password_TF.layer.borderColor = UIColor.lightGray.cgColor
            } else {
                password_TF.layer.borderColor = UIColor.red.cgColor
            }
    }
    func validateEmail( ) {
            guard let text = email_TF.text else { return }
            
        if authManager.isEmailValid(text) {
                email_TF.layer.borderColor = UIColor.lightGray.cgColor
            } else {
                email_TF.layer.borderColor = UIColor.red.cgColor
            }
    }
}

extension Signup_VC:SignUpDelegate{
    func googleSignUpSuccessfully() {
        let storyboard = UIStoryboard(name: "HomeStoryboard", bundle: nil)
        let nextViewController = storyboard.instantiateViewController(withIdentifier: Constants.SCREEN_ID_HOME)
        nextViewController.modalPresentationStyle = .fullScreen
        present(nextViewController, animated: true, completion: nil)
    }
    
    func signUpSuccessfully() {
        let storyboard = UIStoryboard(name: "Login_SB", bundle: nil)
        let nextViewController = storyboard.instantiateViewController(withIdentifier: Constants.SCREEN_ID_LOGIN) as!Login_VC
        nextViewController.modalPresentationStyle = .fullScreen
        present(nextViewController, animated: true, completion: nil)
    }
    
    func SignUpFailed() {
        print("failed to login")
        AlertCreator.showAlert(title: "Alert", message: "Register Failed. Already User Exist.", viewController: self)
    }
    
//
//    func didLoginSuccessfully() {
//        let storyboard = UIStoryboard(name: "Login_SB", bundle: nil)
//        let nextViewController = storyboard.instantiateViewController(withIdentifier: Constants.SCREEN_ID_LOGIN) as!Login_VC
//        //nextViewController.customer = model
//        nextViewController.modalPresentationStyle = .fullScreen
//        present(nextViewController, animated: true, completion: nil)
//    }
//
//    func loginFailed() {
//   }
//    func userNotVerified(user : User)
//    {
//        print("verification not compeleted")
//    }
    
}

extension UITextField{
    func addPaddingToTF(){
        let paddingView:UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: 8, height: 0))
        self.leftView = paddingView
        self.rightView = paddingView
        self.rightViewMode = .always
        self.leftViewMode = .always
    }
}
