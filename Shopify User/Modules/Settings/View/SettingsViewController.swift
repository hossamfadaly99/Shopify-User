//
//  SettingsViewController.swift
//  Shopify User
//
//  Created by Hossam on 19/06/2023.
//

import UIKit

class SettingsViewController: UIViewController {

  @IBOutlet weak var popUpBtn: UIButton!

  var sizes: [String]? = ["EGP", "USD", "EUR"]
    override func viewDidLoad() {
        super.viewDidLoad()
      setPopUpButton()
        // Do any additional setup after loading the view.
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

extension SettingsViewController  {
    func setPopUpButton(){
        var action :[UIAction] = []
        let optionSelected = {(action : UIAction) in
            //show selected size title
            print(action.title)
        }
        guard let sizes = sizes else {return}
        if (sizes.isEmpty){
            action.append( UIAction(title: "Sizes", handler: optionSelected) )
        } else {
            action = []
            for item in sizes{
                action.append( UIAction(title: item, handler: optionSelected))
                //action.state = .on
               // print("func :")
            }

        }
        popUpBtn.menu = UIMenu(children: action)
        popUpBtn.showsMenuAsPrimaryAction = true
        popUpBtn.changesSelectionAsPrimaryAction = true
    }
}
