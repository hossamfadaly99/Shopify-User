//
//  ProductsTableCell.swift
//  Shopify User
//
//  Created by Mac on 14/06/2023.
//

import UIKit

class ProductsTableCell: UITableViewCell {

    @IBOutlet weak var productTypeLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
