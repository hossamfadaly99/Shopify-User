//
//  Utilities.swift
//  Shopify User
//
//  Created by Hossam on 04/06/2023.
//

import Foundation
import UIKit

func makeTableCellCornerRadius(cell: UITableViewCell){
//  cell.contentView.backgroundColor = UIColor(named: "gray_e")
//  cell.contentView.layer.borderWidth = 2
//  cell.contentView.layer.borderColor = UIColor.black.cgColor
  cell.contentView.layer.cornerRadius = 16
}

func setupTFBorder(tf: UITextField, width: CGFloat = 1, raduis: CGFloat = 8){
  tf.layer.borderWidth = width
  tf.layer.cornerRadius = raduis
}
