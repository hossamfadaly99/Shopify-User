//
//  SettingsViewModel.swift
//  Shopify User
//
//  Created by Hossam on 18/06/2023.
//

import Foundation

class SettingsViewModel{
    var dataManager : DataManagerProtocol

  let defaults = UserDefaults.standard
  var networkManager: NetworkServiceProtocol
  var stopAnimation: ()->() = {}
  var isCurrencyUpdated: Bool = false {
    didSet{
      stopAnimation()
    }
  }

  init(networkManager: NetworkServiceProtocol,dataManager: DataManagerProtocol) {
    self.networkManager = networkManager
      self.dataManager = dataManager
  }
    func deleteAllFromDB(user_id :String){
        dataManager.deleteAllProductsForUser(userId: user_id )
    }
    
  func loadLatestCurrency(chosenCurrency: String){
    networkManager.fetchData{ [weak self] (result: Currency?) in
      self?.defaults.set(chosenCurrency, forKey: Constants.CURRENCY_KEY)
      self?.defaults.set(result?.rates?[chosenCurrency], forKey: Constants.CURRENCY_VALUE)
      self?.isCurrencyUpdated.toggle()

    }
  }
}
