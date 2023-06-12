//
//  CheckoutViewController.swift
//  Shopify User
//
//  Created by Hossam on 12/06/2023.
//

import UIKit
import PassKit

class CheckoutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

  @IBAction func purchaseBtnClick(_ sender: Any) {
      // TODO: make it
    var paymentStrategy = ApplePaymentStrategy()
    let paymentcontext = PaymentContext(pyamentStrategy: paymentStrategy)

    //paymentcontext.setPaymentStrategy(paymentStrategy: <#T##PaymentStrategy#>)

    let controller = PKPaymentAuthorizationViewController(paymentRequest: paymentStrategy.getPaymentReq())
    controller?.delegate = self
    present(controller!, animated: true){
      print("presented")
    }

    let isPaymentSuccessful = paymentcontext.makePayment(amount: 135.0)

    if isPaymentSuccessful {
      print("successful purshase")
    } else {
      print("failed purshase")
    }
  }
}
