//
//  Signup_VC.swift
//  Shopify User
//
//  Created by MAC on 04/06/2023.
//

import UIKit

class Signup_VC: UIViewController {
    @IBOutlet weak var email_TF: UITextField!
    @IBOutlet weak var firstName_TF: UITextField!
    
    @IBOutlet weak var lastName_TF: UITextField!
    
    @IBOutlet weak var password_TF: UITextField!
    
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
}
    
    
    @IBAction func signin(_ sender: Any) {
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
