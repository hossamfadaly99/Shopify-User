//
//  AddressCell.swift
//  Shopify User
//
//  Created by Hossam on 17/06/2023.
//

import UIKit

class AddressCell: UITableViewCell {

  @IBOutlet weak var mainAddressLabel: UILabel!
  @IBOutlet weak var SecondAddressLabel: UILabel!
  @IBOutlet weak var mobileLabel: UILabel!

  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

  func loadAddressData(_ address: Address_){
    self.mainAddressLabel.text = address.address1
    self.SecondAddressLabel.text = "\(address.address2 ?? ""), \(address.city ?? ""), \(address.province ?? ""), \(address.country ?? "")"
    self.mobileLabel.text = address.phone
  }
  @IBAction func editBtnClick(_ sender: Any) {
    //navigate to edit

  }

}
