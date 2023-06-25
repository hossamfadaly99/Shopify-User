//
//  SettingsTableViewController.swift
//  Shopify User
//
//  Created by Hossam on 19/06/2023.
//

import UIKit
import PKHUD

class SettingsTableViewController: UITableViewController {

    @IBOutlet weak var labelState: UILabel!
    var sizes: [String]? = ["EGP", "USD", "EUR"]
  var viewModel: SettingsViewModel!
  let defaults = UserDefaults.standard

  @IBOutlet weak var popUpBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        print("User id : \( UserDefaults.standard.string(forKey: Constants.KEY_USER_ID))")
      viewModel = SettingsViewModel(networkManager: NetworkManager(url: URLCreator().getCurrencyURL()),dataManager: DataManager.sharedInstance)
      setPopUpButton()

      viewModel.stopAnimation = {
        HUD.hide(animated: true)
        print(UserDefaults.standard.string(forKey: "currency_value") ?? "1")
      }

    }

    override func viewWillAppear(_ animated: Bool) {
        guard let state = UserDefaults.standard.string(forKey: Constants.KEY_USER_STATE) else{return}
        if(state == Constants.USER_STATE_GUEST){
            labelState.text = "SignUp"
        } else {
            labelState.text = "LogOut"
        }
    }
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print(indexPath)
    if indexPath.section == 2 && indexPath.row == 0 {
            logout()
        }
  }

   func logout() {
       guard let state = UserDefaults.standard.string(forKey: Constants.KEY_USER_STATE) else{return}
       if(state == Constants.USER_STATE_GUEST){
           let storyboard = UIStoryboard(name: "Signup_SB", bundle: nil)
           let nextViewController = storyboard.instantiateViewController(withIdentifier: Constants.SCREEN_ID_SIGNUP) as! Signup_VC
           nextViewController.modalPresentationStyle = .fullScreen
           present(nextViewController, animated: true)
           
       } else {
           guard let my_Customer_id = UserDefaults.standard.string(forKey: Constants.KEY_USER_ID) else {return}
           defaults.set("", forKey: Constants.KEY_USER_FIRSTNAME)
           defaults.set("", forKey: Constants.KEY_USER_LASTNAME)
           defaults.set("", forKey: Constants.KEY_USER_EMAIL)
           defaults.set(Constants.USER_STATE_LOGOUT, forKey: Constants.KEY_USER_STATE)
           defaults.set("", forKey: Constants.KEY_USER_ID)
           defaults.set("", forKey: Constants.USER_CART)
           defaults.set("", forKey: Constants.USER_WISHLIST)
           print("Loged out : \( UserDefaults.standard.string(forKey: Constants.USER_CART))")
           viewModel.deleteAllFromDB(user_id: my_Customer_id)
           
           let storyboard = UIStoryboard(name: "Login_SB", bundle: nil)
           let nextViewController = storyboard.instantiateViewController(withIdentifier: Constants.SCREEN_ID_LOGIN) as! Login_VC
           nextViewController.modalPresentationStyle = .fullScreen
           present(nextViewController, animated: true, completion: nil)
       }
  }

}

extension SettingsTableViewController  {
    func setPopUpButton(){
        var action :[UIAction] = []
        let optionSelected = {(action : UIAction) in
            //show selected size title
            print(action.title)
          HUD.show(.labeledProgress(title: nil, subtitle: "loading"))
          self.viewModel.loadLatestCurrency(chosenCurrency: action.title)

        }
        guard let sizes = sizes else {return}
        if (sizes.isEmpty){
            action.append( UIAction(title: "Sizes", handler: optionSelected) )
        } else {
            action = []
          var latestChosen = UserDefaults.standard.string(forKey: Constants.CURRENCY_KEY) ?? "USD"
          action.append(UIAction(title: latestChosen, handler: optionSelected))
            for item in sizes{
              if item != latestChosen{
                action.append( UIAction(title: item, handler: optionSelected))
              }
            }

        }

        popUpBtn.menu = UIMenu(children: action)
        popUpBtn.showsMenuAsPrimaryAction = true
        popUpBtn.changesSelectionAsPrimaryAction = true
    }
}
