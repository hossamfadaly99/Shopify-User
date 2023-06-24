//
//  Snackbar.swift
//  Shopify User
//
//  Created by Hossam on 24/06/2023.
//

import Foundation
import SnackBar
import UIKit
class AdsSnackBar: SnackBar {

  override var style: SnackBarStyle {
    var style = SnackBarStyle()
    style.background = UIColor(named: "main_green")!
    style.textColor = .white
    style.actionFont = .systemFont(ofSize: 17, weight: .bold)
    style.font = .systemFont(ofSize: 15, weight: .semibold)
    style.actionTextColor = .white
    style.actionTextColorAlpha = 1
    return style
  }
}
