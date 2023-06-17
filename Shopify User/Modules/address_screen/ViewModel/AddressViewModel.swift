//
//  AddressViewModel.swift
//  Shopify User
//
//  Created by Hossam on 17/06/2023.
//

import Foundation
class AddressViewModel{
  var networkManager: NetworkServiceProtocol
  var changeAddressUI: ()->() = {}
  var addressList: [Address_] = [] {
    didSet{
      changeAddressUI()
    }
  }

  init(networkManager: NetworkServiceProtocol) {
    self.networkManager = networkManager
  }

  func getAllAddresses(){
    networkManager.fetchData{ [weak self] (result: Addresses?) in
      self?.addressList = result?.addresses ?? []
      
    }
  }

  func addAddress(){
    
  }

  func editAddress(){

  }

  func removeAddress(){

  }


}
