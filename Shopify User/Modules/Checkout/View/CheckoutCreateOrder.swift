//
//  CheckoutCreateOrder.swift
//  Shopify User
//
//  Created by Mac on 19/06/2023.
//

import Foundation
extension CheckoutViewController{
    func createOrder(){
        
        var orderRequest: OrderResponsePost = OrderResponsePost()
      var lineItems: [LineItem] = self.viewModel?.lineItems ?? []
//        var lineItem: LineItem = LineItem()
//        lineItem.variantID = 45372849226020
//        lineItem.quantity = 1
//        lineItems.append(lineItem)

        var customer = OrderCustomer()
        customer.id = 6959049769252
        var address = OrderAddress()
        address.firstName = "Janeeee"
//        address.lastName = "smith"
        address.address1 = "123 Fake Street"
        address.phone = "777-777-7777"
        address.city = "Fakecity"
        address.province = "Ontario"
        address.country = "Canada"
//        address.zip = "K2P 1L4"
        
        var discountCode = DiscountCode()
        discountCode.code = "FAKE30"
        discountCode.amount = "9.00"
        discountCode.type = "percentage"
        
        var discountCodes = Array<DiscountCode>()
        discountCodes.append(discountCode)
        orderRequest.order = OrderPost()
        orderRequest.order?.lineItems = lineItems
        orderRequest.order?.customer = customer
        orderRequest.order?.shippingAddress = address
        orderRequest.order?.financialStatus = "paid"
        orderRequest.order?.discountCodes = discountCodes
        print("a333333aaaaaaaaa")
        print(orderRequest)
        
        self.viewModel?.createOrder(orderItem: orderRequest)
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
