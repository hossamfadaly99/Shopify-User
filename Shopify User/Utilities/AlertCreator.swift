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
}
