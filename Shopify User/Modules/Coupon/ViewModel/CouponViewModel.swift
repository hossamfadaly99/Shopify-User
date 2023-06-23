//
//  CouponViewModel.swift
//  Shopify User
//
//  Created by Hossam on 23/06/2023.
//

import Foundation
class CouponViewModel {
  var networkManager: NetworkServiceProtocol
  var bindCouponsToUI: ()->() = {}
  var couponsLists: [[Coupon]] = []
  var priceRules: [PriceRule] = []
  var savedCoupons: [SavedCoupon] = []
  var isCouponRetrieved: Bool = false{
    didSet{
      DispatchQueue.main.async {
        self.bindCouponsToUI()
      }

    }
  }

  init(networkManager: NetworkServiceProtocol = NetworkManager(url: URLCreator().getAllPriceRulesURL())){
    self.networkManager = networkManager
  }

  func getCoupons(){
    networkManager.setURL(URLCreator().getAllPriceRulesURL())
    networkManager.fetchData{ [weak self] (result: PriceRuleResponse?) in
//      UserDefaults.standard.setValue(result?.priceRules.first?.value, forKey: Constants.COUPON_VALUE_OBJECT)
//      UserDefaults.standard.setValue(result?.priceRules.first?.valueType, forKey: Constants.COUPON_VALUE_TYPE_OBJECT)
      print("all price rules: ")
      print(result?.priceRules)
      print("-----------------")
      self?.priceRules = result?.priceRules ?? []

      for priceRule in result?.priceRules ?? [] {
        self?.networkManager.setURL(URLCreator().getCouponsURL(priceRuleId: "\(priceRule.id ?? 0)"))
      //  print(URLCreator().getCouponsURL(priceRuleId: "\(priceRule.id ?? 0)"))
        self?.networkManager.fetchData{ (result: CouponResponse?) in

          print("single price rule has: ")

//          print(result?.discountCodes)
          for i in result?.discountCodes ?? [] {
//            print(i.code)
            self?.savedCoupons.append(SavedCoupon(code: i.code, value: priceRule.value, type: priceRule.valueType))
          }
//          print(self?.savedCoupons)
          print("-----------------123")
//          UserDefaults.standard.setValue(self?.savedCoupons, forKey: Constants.COUPON_OBJECT)
//            UserDefaults.standard.setValue(initCouponsList.first?.first?.code, forKey: Constants.COUPON_NAME_OBJECT)
            self?.isCouponRetrieved.toggle()
        }
        print("-----------------12333start")
//        DispatchQueue.global().async {
          print(self?.savedCoupons)
          print("-----------------12333end")
//        }

      }
    }
  }
}
