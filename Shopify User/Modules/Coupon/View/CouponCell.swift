//
//  CouponCell.swift
//  Shopify User
//
//  Created by Hossam on 23/06/2023.
//

import UIKit

class CouponCell: UITableViewCell {

  @IBOutlet weak var couponValue: UILabel!
  @IBOutlet weak var couponName: UILabel!

  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

  func setupUI(_ coupon: SavedCoupon){
    self.couponName.text = coupon.code
    self.couponValue.text = coupon.value

  }
  @IBAction func copyCoupon(_ sender: Any) {
    UIPasteboard.general.string = self.couponName.text
  }
}
