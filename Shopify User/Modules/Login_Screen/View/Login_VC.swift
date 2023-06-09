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
    let disposeBag = DisposeBag()
    var viewModel = LoginViewModel()
    var authManager = AuthenticationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        email_TF.addPaddingToTF()
        email_TF.layer.cornerRadius = 15.0
        email_TF.layer.borderWidth = 2.0
        email_TF.layer.borderColor = UIColor.lightGray.cgColor
        
        password_TF.addPaddingToTF()
        password_TF.layer.cornerRadius = 15.0
        password_TF.layer.borderWidth = 2.0
        password_TF.layer.borderColor = UIColor.lightGray.cgColor
        
        setupBindings()

    }
    
    func setupBindings() {
        email_TF.addPaddingToTF()
        email_TF.layer.cornerRadius = 15.0
        email_TF.layer.borderWidth = 2.0
        email_TF.layer.borderColor = UIColor.lightGray.cgColor
        
        password_TF.addPaddingToTF()
      //  password_TF.isSecureTextEntry = true
        password_TF.layer.cornerRadius = 15.0
        password_TF.layer.borderWidth = 2.0
        password_TF.layer.borderColor = UIColor.lightGray.cgColor
                
        loginBtn.rx.tap
            .subscribe(onNext: { [weak self] in self?.viewModel.login() })
            .disposed(by: disposeBag)
    }
    
}

