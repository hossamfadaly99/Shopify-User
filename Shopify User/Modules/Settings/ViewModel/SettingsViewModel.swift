//
//  SettingsViewModel.swift
//  Shopify User
//
//  Created by Hossam on 18/06/2023.
//

import Foundation

class SettingsViewModel{
  let defaults = UserDefaults.standard
  var networkManager: NetworkServiceProtocol
  var stopAnimation: ()->() = {}
  var isCurrencyUpdated: Bool = false {
    didSet{
      stopAnimation()
    }
  }

  init(networkManager: NetworkServiceProtocol) {
    self.networkManager = networkManager
  }

  func loadLatestCurrency(chosenCurrency: String){
    networkManager.fetchData{ [weak self] (result: Currency?) in
      self?.defaults.set(chosenCurrency, forKey: "currency_key")
      self?.defaults.set(result?.rates?[chosenCurrency], forKey: "currency_value")
      self?.isCurrencyUpdated.toggle()

    }
  }
}
