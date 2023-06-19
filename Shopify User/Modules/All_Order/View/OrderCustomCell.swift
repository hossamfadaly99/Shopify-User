//
//  OrderCustomCell.swift
//  Shopify User
//
//  Created by Mac on 19/06/2023.
//

import UIKit

class OrderCustomCell: UITableViewCell {

    @IBOutlet weak var orderTotalPriceLabel: UILabel!
    @IBOutlet weak var orderDateLabel: UILabel!
    @IBOutlet weak var orderIdLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
