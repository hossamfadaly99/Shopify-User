//
//  reviewCell.swift
//  Shopify User
//
//  Created by MAC on 13/06/2023.
//

import UIKit

class reviewCell: UITableViewCell {
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var name: UILabel!
  
    @IBOutlet weak var reviewLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
