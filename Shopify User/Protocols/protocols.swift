//
//  protocols.swift
//  Shopify User
//
//  Created by Mac on 23/06/2023.
//

import Foundation

protocol ReloadTableViewDelegate {
    func reloadTableView()
}

protocol ClickToFavBtnDelegate {
    func clicked(_ row: Int)
}
