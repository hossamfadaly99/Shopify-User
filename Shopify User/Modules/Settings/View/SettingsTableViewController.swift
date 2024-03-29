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
    var favTableViewController : ReloadTableViewDelegate?

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
            labelState.text = "Logout"
        }
    }
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print(indexPath)
    if indexPath.section == 2 && indexPath.row == 0 {
            logout()
        }
  }

    override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
           
           if isBeingDismissed {
               print ("Dismissed")
               // Notify the presenting view controller to reload its data
               favTableViewController?.reloadTableView()
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
           //
           
           let alert : UIAlertController = UIAlertController(title: "Logout!", message: "Are you sure you want to logout?", preferredStyle: .alert)
           
           alert.addAction(UIAlertAction(title: "Logout", style: .destructive,handler: { [weak self] action in
               //                    delete fromm fav
               guard let my_Customer_id = UserDefaults.standard.string(forKey: Constants.KEY_USER_ID) else {return}
               self?.defaults.set("", forKey: Constants.KEY_USER_FIRSTNAME)
               self?.defaults.set("", forKey: Constants.KEY_USER_LASTNAME)
               self?.defaults.set("", forKey: Constants.KEY_USER_EMAIL)
               self?.defaults.set(Constants.USER_STATE_LOGOUT, forKey: Constants.KEY_USER_STATE)
               self?.defaults.set("", forKey: Constants.KEY_USER_ID)
               self?.defaults.set("", forKey: Constants.USER_CART)
               self?.defaults.set("", forKey: Constants.USER_WISHLIST)
               print("Loged out : \( UserDefaults.standard.string(forKey: Constants.USER_CART))")
               self?.viewModel.deleteAllFromDB(user_id: my_Customer_id)
               
               let storyboard = UIStoryboard(name: "Login_SB", bundle: nil)
               let nextViewController = storyboard.instantiateViewController(withIdentifier: Constants.SCREEN_ID_LOGIN) as! Login_VC
               nextViewController.modalPresentationStyle = .fullScreen
               self?.present(nextViewController, animated: true, completion: nil)
               }
           ))
           alert.addAction(UIAlertAction(title: "NO", style: .cancel,handler:nil))
           present(alert, animated: true, completion: nil)
           
           //
           
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
