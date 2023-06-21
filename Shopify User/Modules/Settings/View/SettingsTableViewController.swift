//
//  SettingsTableViewController.swift
//  Shopify User
//
//  Created by Hossam on 19/06/2023.
//

import UIKit
import PKHUD

class SettingsTableViewController: UITableViewController {

  var sizes: [String]? = ["EGP", "USD", "EUR"]
  var viewModel: SettingsViewModel!
  let defaults = UserDefaults.standard

  @IBOutlet weak var popUpBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
      viewModel = SettingsViewModel(networkManager: NetworkManager(url: URLCreator().getCurrencyURL()))
      setPopUpButton()

      viewModel.stopAnimation = {
        HUD.hide(animated: true)
        print(UserDefaults.standard.string(forKey: "currency_value") ?? "1")
      }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print(indexPath)
    if indexPath.section == 2 && indexPath.row == 0 {
            logout()
        }
  }

   func logout() {
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
          var latestChosen = UserDefaults.standard.string(forKey: "currency_key") ?? "USD"
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
