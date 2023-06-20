//
//  Profile_VC.swift
//  Shopify User
//
//  Created by MAC on 15/06/2023.
//

import UIKit

class Profile_VC: UIViewController {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var mail: UILabel!
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        if let customer_id = UserDefaults.standard.string(forKey: Constants.KEY_USER_ID)
        {

            print("Welcome back, \(customer_id)!")
        } else {
            print("No username found.")
        }
        if let customer_name = UserDefaults.standard.string(forKey: Constants.KEY_USER_FIRSTNAME)
        {
            name.text = customer_name

            print("Welcome back, \(customer_name)!")
        } else {
            print("No username found.")
        }
        if let customer_email = UserDefaults.standard.string(forKey: Constants.KEY_USER_EMAIL)
        {
            mail.text = customer_email
            print("Welcome back, \(customer_email)!")
        } else {
            print("No username found.")
        }
        // Do any additional setup after loading the view.
    }
    

    @IBAction func logout(_ sender: Any) {
        defaults.set("", forKey: Constants.KEY_USER_FIRSTNAME)
        defaults.set("", forKey: Constants.KEY_USER_LASTNAME)
        defaults.set("", forKey: Constants.KEY_USER_EMAIL)
        defaults.set(Constants.USER_STATE_LOGOUT, forKey: Constants.KEY_USER_STATE)
        defaults.set("", forKey: Constants.KEY_USER_ID)
        defaults.set("", forKey: Constants.USER_CART)
        defaults.set("", forKey: Constants.USER_WISHLIST)
        print("Loged out : \( UserDefaults.standard.string(forKey: Constants.USER_CART))")
        let storyboard = UIStoryboard(name: "Login_SB", bundle: nil)
        let nextViewController = storyboard.instantiateViewController(withIdentifier: Constants.SCREEN_ID_LOGIN) as! Login_VC
        nextViewController.modalPresentationStyle = .fullScreen
        present(nextViewController, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
