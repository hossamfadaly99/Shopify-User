//
//  Signup_VC.swift
//  Shopify User
//
//  Created by MAC on 04/06/2023.
//

import UIKit
import RxSwift

class Signup_VC: UIViewController {
    @IBOutlet weak var email_TF: UITextField!
    @IBOutlet weak var firstName_TF: UITextField!
    @IBOutlet weak var lastName_TF: UITextField!
    @IBOutlet weak var password_TF: UITextField!
    @IBOutlet weak var signupBtn: UIButton!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var zipCity: UITextField!
    @IBOutlet weak var cityName: UITextField!
    @IBOutlet weak var countryName: UITextField!
    
    
    let disposeBag = DisposeBag()
    var viewModel = SignupViewModel()
    var authManager = AuthenticationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        print("started")
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
        
        phone.addPaddingToTF()
        phone.layer.cornerRadius = 15.0
        phone.layer.borderWidth = 2.0
        phone.layer.borderColor = UIColor.lightGray.cgColor
        
        zipCity.addPaddingToTF()
        zipCity.layer.cornerRadius = 15.0
        zipCity.layer.borderWidth = 2.0
        zipCity.layer.borderColor = UIColor.lightGray.cgColor
        
        countryName.addPaddingToTF()
        countryName.layer.cornerRadius = 15.0
        countryName.layer.borderWidth = 2.0
        countryName.layer.borderColor = UIColor.lightGray.cgColor
        
        cityName.addPaddingToTF()
        cityName.layer.cornerRadius = 15.0
        cityName.layer.borderWidth = 2.0
        cityName.layer.borderColor = UIColor.lightGray.cgColor
        
        setupBindings()
    }
    
    @IBAction func signWithGoogle(_ sender: Any) {
        
        
    }
    @IBAction func navigate(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Login_SB", bundle: nil) // Replace "Main" with your storyboard name
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
        
        phone.rx.text.orEmpty
            .bind(to: viewModel.phone)
            .disposed(by: disposeBag)
        
        zipCity.rx.text.orEmpty
            .bind(to: viewModel.zip)
            .disposed(by: disposeBag)
        
        cityName.rx.text.orEmpty
            .bind(to: viewModel.cityName)
            .disposed(by: disposeBag)
        
        countryName.rx.text.orEmpty
            .bind(to: viewModel.countryName)
            .disposed(by: disposeBag)
        
        viewModel.isValid(authManager: authManager)
            .bind(to: signupBtn.rx.isEnabled)
            .disposed(by: disposeBag)
        
        signupBtn.rx.tap
            .subscribe(onNext: { [weak self] in self?.viewModel.signup() })
            .disposed(by: disposeBag)
    }
}

extension Signup_VC:ViewModelDelegate{
    func didLoginSuccessfully() {
        print ("hi")
        let storyboard = UIStoryboard(name: "HomeStoryboard", bundle: nil)
        let nextViewController = storyboard.instantiateViewController(withIdentifier: Constants.SCREEN_ID_HOME) as! HomeViewController
            nextViewController.modalPresentationStyle = .fullScreen
            present(nextViewController, animated: true, completion: nil)
    }
    
    func loginFailed() {
        //toast or alert
        print("failed to login")
    }

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
