//
//  CheckoutViewController.swift
//  Shopify User
//
//  Created by Hossam on 12/06/2023.
//

import UIKit
import PassKit
import PKHUD
import RxSwift
import RxCocoa

class CheckoutViewController: UIViewController {
    var amount: Double = 0.0
    let disposeBag = DisposeBag()
    var viewModel : CheckoutViewModel?
    var line_Items: [Line_items] = []
  var isAddressAdded: Bool = true
    var emptyCartProtocol: EmptyCartProtocol!
  var appliedCoupon: SavedCoupon? = nil
    var totalAmountWithDelivery: Double {
      return amount + 10.0 * currencyValue - (Double(discountAmountLabel.text?.dropLast(4).dropFirst() ?? "0.0") ?? 0.0) ?? 0.0
  }
  @IBOutlet weak var addressOneLabel: UILabel!
  @IBOutlet weak var addressTwoLabel: UILabel!

  @IBOutlet weak var shippingView: UIView!
  @IBOutlet weak var ChangeAddressBtn: UIButton!
  @IBOutlet weak var couponTF: UITextField!

  @IBOutlet weak var discountAmountLabel: UILabel!

  @IBOutlet weak var summaryAmountLabel: UILabel!
  @IBOutlet weak var deliveryAmountLabel: UILabel!
  @IBOutlet weak var orderAmountLabel: UILabel!

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    viewModel?.getDefaultAddress()
  }
  override func viewDidLoad() {
        super.viewDidLoad()
      self.navigationController?.navigationBar.isHidden = true
    setupTFBorder(tf: couponTF, width: 0.5, raduis: 8)
    shippingView.layer.cornerRadius = 16
    shippingView.layer.borderWidth = 0.5
//    var afterCurrency = String(format: "%.2f \(currencySymbol)", amount * currencyValue)
    observeCouponTF()
    print("ltgblrtk")
    print(amount)
    var afterCurrency = String(format: "%.2f \(currencySymbol)", amount)
    orderAmountLabel.text = afterCurrency//"\(amount * currencyValue)\(currencySymbol)"
    afterCurrency = String(format: "%.2f \(currencySymbol)", 10 * currencyValue)
    deliveryAmountLabel.text = afterCurrency//"\(10 * currencyValue) \(currencySymbol)"
    afterCurrency = String(format: "%.2f \(currencySymbol)", totalAmountWithDelivery )
    summaryAmountLabel.text = afterCurrency//"\(totalAmountWithDelivery * currencyValue)\(currencySymbol)"
    viewModel = CheckoutViewModel(networkManager: NetworkManager(url: URLCreator().getCreateOrder()))
    viewModel?.transferObject(items: line_Items)
    viewModel?.getDefaultAddress()
    viewModel?.bindResultToViewController = {
      HUD.hide()
    }
    viewModel?.bindDefaultAddress = {
      var address = self.viewModel?.defaultAddress
      self.addressOneLabel.text = address?.address1
      self.addressTwoLabel.text = "\(address?.address2 ?? ""), \(address?.city ?? ""), \(address?.province ?? ""), \(address?.country ?? "")"
      print("enkentgkjtn")
      print(self.addressTwoLabel.text)
      if self.addressTwoLabel.text == ", , , " {
        self.addressTwoLabel.text = "No address added!"
        self.ChangeAddressBtn.titleLabel?.text = "Add"
        self.isAddressAdded = false
      } else {
        self.ChangeAddressBtn.titleLabel?.text = "Change"
        self.isAddressAdded = true
      }
    }

    }

  @IBAction func backBtnClick(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
  }

  func isCardMethodSelected() -> Bool {
    if let cardImage = self.view.viewWithTag(2) as? UIImageView{
      if !cardImage.isHidden{
        return true
      }else {
        return false
      }
    }
    return false
  }
  @IBAction func purchaseBtnClick(_ sender: Any) {

    if !isAddressAdded {
      AlertCreator.showAlert(title: nil, message: "No Address Added", viewController: self)
    } else {
      
      let paymentcontext = PaymentContext(pyamentStrategy: CashPaymentStrategy())
      
      if isCardMethodSelected(){
        paymentcontext.setPaymentStrategy(paymentStrategy: ApplePaymentStrategy())
      }
      
      let isPaymentSuccessful = paymentcontext.makePayment(amount: self.totalAmountWithDelivery, vc: self)
      
      if isPaymentSuccessful.0 {
        if isPaymentSuccessful.1 == "Purchased successfully"{
          //handle server side to make it order
          HUD.show(.progress)
          self.createOrder()
          self.emptyCartProtocol.makeCartEmpty()
          self.navigationController?.popViewController(animated: true)
          
        }
        print(isPaymentSuccessful.1)
      } else {
        AlertCreator.showAlert(title: nil, message: isPaymentSuccessful.1, viewController: self)
        print(isPaymentSuccessful.1)
      }
    }
  }
  
  @IBAction func applyCoupon(_ sender: Any) {
    if let coupon = getCouponsFromUserDefaults() {
      if coupon.type == "fixed_amount" {
        var afterCurrency = String(format: "%.2f \(currencySymbol)", (Double(coupon.value ?? "0.0") ?? 0.0 ) * currencyValue)
        self.discountAmountLabel.text = afterCurrency
        afterCurrency = String(format: "%.2f \(currencySymbol)", totalAmountWithDelivery )
        summaryAmountLabel.text = afterCurrency
      } else {
        let discountPrecentage: Double = ((Double(coupon.value ?? "0.0") ?? 0.0 ) / 100.0)

        let discountValue = ((Double(coupon.value ?? "0.0") ?? 0.0 ) / 100.0) * (Double(self.orderAmountLabel.text?.dropLast(4) ?? "0.0") ?? 0.0)
        var afterCurrency = String(format: "%.2f \(currencySymbol)", discountValue)
        self.discountAmountLabel.text = afterCurrency
        self.appliedCoupon = coupon
        afterCurrency = String(format: "%.2f \(currencySymbol)", totalAmountWithDelivery )
        summaryAmountLabel.text = afterCurrency
      }

    } else {
      self.appliedCoupon = nil
      var afterCurrency = String(format: "%.2f \(currencySymbol)", totalAmountWithDelivery )
      summaryAmountLabel.text = afterCurrency
      AlertCreator.showAlertWithAction(title: "No coupons found", message: "Do you want see all coupns?", viewController: self){
        let sb = UIStoryboard(name: "CouponStoryboard", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "CouponViewController")
        self.navigationController?.pushViewController(vc, animated: true)

      }

    }

  }

}

extension CheckoutViewController {

  func observeCouponTF(){
    self.couponTF.rx.text.orEmpty
        .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
        .subscribe(onNext: { text in
          if let coupon = self.getCouponsFromUserDefaults() {
            if coupon.type == "fixed_amount" {
              var afterCurrency = String(format: "%.2f \(currencySymbol)", (Double(coupon.value ?? "0.0") ?? 0.0 ) * currencyValue)
              self.discountAmountLabel.text = afterCurrency
              afterCurrency = String(format: "%.2f \(currencySymbol)", self.totalAmountWithDelivery )
              self.summaryAmountLabel.text = afterCurrency
            } else {
              let discountValue = ((Double(coupon.value ?? "0.0") ?? 0.0 ) / 100.0) * (Double(self.orderAmountLabel.text?.dropLast(4) ?? "0.0") ?? 0.0)
              var afterCurrency = String(format: "%.2f \(currencySymbol)", discountValue)
              self.discountAmountLabel.text = afterCurrency
              self.appliedCoupon = coupon
              afterCurrency = String(format: "%.2f \(currencySymbol)", self.totalAmountWithDelivery )
              self.summaryAmountLabel.text = afterCurrency
            }

          } else {
            self.discountAmountLabel.text = "- 0 \(currencySymbol)"
            self.appliedCoupon = nil
            var afterCurrency = String(format: "%.2f \(currencySymbol)", self.totalAmountWithDelivery )
            self.summaryAmountLabel.text = afterCurrency
          }

            // Perform your desired action here
        })
        .disposed(by: disposeBag)

  }

  //dealing with coupons
  func getCouponsFromUserDefaults()-> SavedCoupon? {
    // Retrieve the data object from UserDefaults
    if let data = UserDefaults.standard.data(forKey: Constants.COUPON_OBJECT) {
        // Convert the data object back to an array of objects
      do {
        if let coupons = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [SavedCoupon] {
          let coupon = coupons.filter{$0.code == self.couponTF.text}.first
          return coupon
        }
      } catch {
        print("connot find coupons in user default")
      }
    }
    return nil
  }
}




extension CheckoutViewController: PKPaymentAuthorizationViewControllerDelegate{
  func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
    controller.dismiss(animated: true)
  }

  func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {

    let paymentAuthorizationResult = PKPaymentAuthorizationResult(status: .success, errors: nil)
    completion(paymentAuthorizationResult)
    if paymentAuthorizationResult.status == .failure{
      print("failed")
    }

    if paymentAuthorizationResult.status == .success{
      print("success")
      controller.dismiss(animated: true)
      self.createOrder()
      self.emptyCartProtocol.makeCartEmpty()
      self.navigationController?.popViewController(animated: true)
      // TODO: make the cart empty and send server req for payment
    }
  }

}
