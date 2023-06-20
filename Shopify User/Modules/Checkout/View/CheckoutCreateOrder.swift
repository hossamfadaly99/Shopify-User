//
//  CheckoutCreateOrder.swift
//  Shopify User
//
//  Created by Mac on 19/06/2023.
//

import Foundation
extension CheckoutViewController{
    func createOrder(){

        var customer = OrderCustomer()
        customer.id = 6959049769252
      var address = self.viewModel?.address
      print("ekbjhbrbk")
      print(self.viewModel?.address)
////      var address = OrderAddress()
//        address.firstName = "Janeeee"
////        address.lastName = "smith"
//        address.address1 = "123 Fake Street"
//        address.phone = "777-777-7777"
//        address.city = "Fakecity"
//        address.province = "Ontario"
//        address.country = "Canada"
////        address.zip = "K2P 1L4"
        
        var discountCode = DiscountCode()
        discountCode.code = "FAKE30"
        discountCode.amount = "9.00"
        discountCode.type = "percentage"
        
        var discountCodes = Array<DiscountCode>()
//        discountCodes.append(discountCode)
        self.viewModel?.orderRequest.order = OrderPost()
        self.viewModel?.orderRequest.order?.lineItems = self.viewModel?.lineItems ?? []
        self.viewModel?.orderRequest.order?.customer = customer
        self.viewModel?.orderRequest.order?.shippingAddress = address
        self.viewModel?.orderRequest.order?.financialStatus = "paid"
//        self.viewModel?.orderRequest.order?.discountCodes = discountCodes
      var codes = UserDefaults.standard.string(forKey: Constants.COUPON_NAME_OBJECT)
      discountCode.amount = codes.code
      discountCodes.append(discountCode)
        self.viewModel?.orderRequest.order?.discountCodes = [codes]
        print("a333333aaaaaaaaa")
        print(self.viewModel?.orderRequest)
        
      self.viewModel?.createOrder(orderItem: self.viewModel!.orderRequest)
    }
}
/*{
 "order": {
     "line_items": [
         {
             "variant_id": 45372849226020,
             "quantity": 1
         }
     ],
     "customer": {
         "id": 6948853350692
     },
     "shipping_address": {
         "first_name": "Jane",
         "last_name": "Smith",
         "address1": "123 Fake Street",
         "phone": "777-777-7777",
         "city": "Fakecity",
         "province": "Ontario",
         "country": "Canada",
         "zip": "K2P 1L4"
     },
     "financial_status": "paid",
     "discount_codes": [
         {
             "code": "FAKE30",
             "amount": "9.00",
             "type": "percentage"
         }
     ]
 }
}*/
