//
//  AddressViewModel.swift
//  Shopify User
//
//  Created by Hossam on 17/06/2023.
//

import Foundation
class AddressViewModel{
  var addressRequest: AddressRequest = AddressRequest()
  var addressId: String = ""
  var networkManager: NetworkServiceProtocol
  var changeAddressUI: ()->() = {}
  var showErrorDialog: ()->() = {}
  var addressList: [Address_] = [] {
    didSet{
      changeAddressUI()
    }
  }
  var isAddressUpdated: Bool = false {
    didSet{
      changeAddressUI()
    }
  }

  init(networkManager: NetworkServiceProtocol) {
    self.networkManager = networkManager
  }

  func getAllAddresses(){
    networkManager.setURL(URLCreator().getAddressURL(customerId: "6947695657252"))
    networkManager.fetchData{ [weak self] (result: Addresses?) in
      print("get allllllll")
      self?.addressList = result?.addresses ?? []
      
    }
  }

  func addAddress(){
    print(addressRequest)
    networkManager.setURL(URLCreator().getAddressURL(customerId: "6947695657252"))
    networkManager.uploadData(object: addressRequest, method: .post){ [weak self] (result: CustomerAddressResponse?) in
//      self?.getAllAddresses()
      print(result)
      if result?.customerAddress == nil{
        self?.showErrorDialog()
      } else {
        self?.isAddressUpdated.toggle()
      }
    }
    
  }

  func editAddress(){
    print("monica \(addressRequest.address?.id )")
    networkManager.setURL(URLCreator().getEditOrDeleteAddressURL(customerId: "6947695657252", addressId: "\(addressRequest.address?.id ?? 0)"))
    print(URLCreator().getEditOrDeleteAddressURL(customerId: "6947695657252", addressId: "\(addressRequest.address?.id ?? 0)"))
    print("monicaaaa: \(addressRequest)")
    networkManager.updateData(object: addressRequest, method: .put){ [weak self] (result: CustomerAddressResponse?) in
      if result?.customerAddress == nil{
        self?.showErrorDialog()
      } else {
        self?.isAddressUpdated.toggle()
      }
//      self?.getAllAddresses()
      print("nilllllll123456")
      print(result)

    }
  }

  func removeAddress(){
    networkManager.setURL(URLCreator().getEditOrDeleteAddressURL(customerId: "6947695657252", addressId: "\(self.addressId)"))
    print(URLCreator().getEditOrDeleteAddressURL(customerId: "6947695657252", addressId: "\(self.addressId)"))
    networkManager.deleteData(object: addressRequest){
      print("deleted before get allllllll")
      self.getAllAddresses()
    }
  }
  func makeAddressDefault(){
    networkManager.setURL(URLCreator().setDefaultAddressURL(customerId: "6947695657252", addressId: "\(self.addressId)"))
    print(URLCreator().setDefaultAddressURL(customerId: "6947695657252", addressId: "\(self.addressId)"))
    networkManager.updateDataa(){[weak self] (response: CustomerAddressResponse?) in
      self?.getAllAddresses()
    }
  }


}
