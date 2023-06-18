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
    networkManager.fetchData{ [weak self] (result: Addresses?) in
      self?.addressList = result?.addresses ?? []
      
    }
  }

  func addAddress(){
    networkManager.uploadData(object: addressRequest, method: .post){ [weak self] (result: CustomerAddressResponse?) in
//      self?.getAllAddresses()
      print(result)
      self?.isAddressUpdated.toggle()
    }
    
  }

  func editAddress(){
    print("monica \(addressRequest.address?.id )")
    networkManager.setURL(URLCreator().getAddressURL(customerId: "6938863698212", addressId: "\(addressRequest.address?.id )"))
    print("monicaaaa: \(addressRequest)")
    networkManager.updateData(object: addressRequest, method: .put){ [weak self] (result: CustomerAddressResponse?) in
//      self?.getAllAddresses()
      print(result)
      self?.isAddressUpdated.toggle()
    }
  }

  func removeAddress(){

  }


}
