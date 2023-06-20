//
//  HomeViewModel.swift
//  Shopify User
//
//  Created by Mac on 04/06/2023.
//

import Foundation
import Alamofire

class HomeViewModel{
    var bindResultToViewController : (()->()) = {}
    var result : [SmartCollection]!{
        didSet{
            bindResultToViewController()
        }
    }
  var networkManager: NetworkServiceProtocol
  var showCouponAlert: ()->() = {}
  var couponsLists: [[Coupon]] = []
  var isCouponRetrieved: Bool = false{
    didSet{
      showCouponAlert()
    }
  }

  init(networkManager: NetworkServiceProtocol = NetworkManager(url: URLCreator().getAllPriceRulesURL())){
    self.networkManager = networkManager
  }

    func getItems(){
//        let param = ["met":"Leagues","APIkey":"fb7419108b900032b89d25268411cef54132de43ba4ceec5dd189418a60a6d33"]
        let headers: HTTPHeaders = [
            HTTPHeader(name: "X-Shopify-Access-Token", value: "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")
               ]
        let url = "https://mad43-sv-ios3.myshopify.com/admin/api/2023-04/smart_collections.json"
        MonicaNetworkManager().loadData(url : url,param: Parameters(),header: headers) { [weak self] (result : Response? ,error) in
            self?.result = result?.smart_collections
        }
    }

  func getCoupons(){
    networkManager.setURL(URLCreator().getAllPriceRulesURL())
    networkManager.fetchData{ [weak self] (result: PriceRuleResponse?) in
      UserDefaults.standard.setValue(result?.priceRules.first?.value, forKey: Constants.COUPON_VALUE_OBJECT)
      UserDefaults.standard.setValue(result?.priceRules.first?.valueType, forKey: Constants.COUPON_VALUE_TYPE_OBJECT)
      var initCouponsList: [[Coupon]] = []
      for priceRule in result?.priceRules ?? [] {
        self?.networkManager.setURL(URLCreator().getCouponsURL(priceRuleId: "\(priceRule.id ?? 0)"))
        print(URLCreator().getCouponsURL(priceRuleId: "\(priceRule.id ?? 0)"))
        self?.networkManager.fetchData{ (result: CouponResponse?) in
//          print("resssulttt")
//          print(result?.discountCodes)
//          print("-------------------resssult--------------------------")
//          initCouponsList.append(result?.discountCodes ?? [])
//          print("addingggggg")
//          print(result?.discountCodes)
//          print("-------------------to--------------------------")
          initCouponsList.append(result?.discountCodes ?? [])
//          print("initcouponsList00")
//          print(initCouponsList)

          if !initCouponsList.isEmpty{
            self?.couponsLists = initCouponsList
            UserDefaults.standard.setValue(initCouponsList.first?.first?.code, forKey: Constants.COUPON_NAME_OBJECT)
            self?.isCouponRetrieved.toggle()
            return
          }
        }
        print("initcouponsList11")
        print(initCouponsList)
      }
      print("initcouponsList")
      print(initCouponsList)
//      self?.couponsLists = initCouponsList

    }

  }

}
