//
//  AlertCreator.swift
//  Shopify User
//
//  Created by MAC on 14/06/2023.
//

import Foundation
import UIKit
class AlertCreator{
    static func showAlert(title: String?, message: String?, viewController: UIViewController) {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            viewController.present(alertController, animated: true, completion: nil)
        }
    static func SignUpAlert(viewController: UIViewController) {
            let alertController = UIAlertController(title: "SignUp", message: "You are not allowed to use this feature because you're guest. Do you want to signUp?", preferredStyle: .alert)
        let signUpAction = UIAlertAction(title: "SignUp", style: .default) { _ in
           // print("Loged out : \( UserDefaults.standard.string(forKey: Constants.USER_CART))")
            let storyboard = UIStoryboard(name: "Signup_SB", bundle: nil)
            let nextViewController = storyboard.instantiateViewController(withIdentifier: Constants.SCREEN_ID_SIGNUP) as! Signup_VC
            nextViewController.modalPresentationStyle = .fullScreen
            viewController.present(nextViewController, animated: true)
        }
            let noAction = UIAlertAction(title: "No", style: .default ,handler: nil)
        
            alertController.addAction(signUpAction)
            alertController.addAction(noAction)
            viewController.present(alertController, animated: true, completion: nil)
        }
}
