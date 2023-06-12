//
//  Login_VC.swift
//  Shopify User
//
//  Created by MAC on 04/06/2023.
//

import UIKit
import RxSwift

class Login_VC: UIViewController {
    @IBOutlet weak var email_TF: UITextField!
    @IBOutlet weak var password_TF: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    
    let disposeBag = DisposeBag()
    var viewModel = LoginViewModel()
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
            let storyboard = UIStoryboard(name: "Signup_SB", bundle: nil) // Replace "Main" with your storyboard name
            let nextViewController = storyboard.instantiateViewController(withIdentifier: Constants.SCREEN_ID_SIGNUP) as! Signup_VC
            nextViewController.modalPresentationStyle = .fullScreen
            self.present(nextViewController, animated: true, completion: nil)
        }).disposed(by: disposeBag)
        setupBindings()

    }
    
    func setupBindings() {
        
        email_TF.rx.text.orEmpty
            .bind(to: viewModel.email)
            .disposed(by: disposeBag)
        
        password_TF.rx.text.orEmpty
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)
        
        viewModel.isValid(authManager: authManager)
            .bind(to: loginBtn.rx.isEnabled)
            .disposed(by: disposeBag)
                
        loginBtn.rx.tap
            .subscribe(onNext: { [weak self] in self?.viewModel.login() })
            .disposed(by: disposeBag)
    }
    
}
extension Login_VC:ViewModelDelegate{
    func didLoginSuccessfully() {
        print ("hi")
            let storyboard = UIStoryboard(name: "HomeStoryboard", bundle: nil) // Replace "Main" with your storyboard name
        let nextViewController = storyboard.instantiateViewController(withIdentifier: Constants.SCREEN_ID_HOME)
       // as! HomeViewController
            nextViewController.modalPresentationStyle = .fullScreen
            present(nextViewController, animated: true, completion: nil)

//            navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    func loginFailed() {
        //toast or alert
        print("failed to login")
    }

}
