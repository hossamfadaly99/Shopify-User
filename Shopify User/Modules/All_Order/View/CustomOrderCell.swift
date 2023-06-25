//
//  CustomOrderCell.swift
//  Shopify User
//
//  Created by Hossam on 25/06/2023.
//

import UIKit

class CustomOrderCell: UITableViewCell {

  @IBOutlet weak var productName: UILabel!

  @IBOutlet weak var quantityLabel: UILabel!

  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
