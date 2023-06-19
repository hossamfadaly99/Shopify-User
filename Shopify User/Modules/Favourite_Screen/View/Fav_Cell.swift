//
//  Fav_Cell.swift
//  Shopify User
//
//  Created by MAC on 18/06/2023.
//

import UIKit
import Cosmos

class Fav_Cell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var ratingCosmos: CosmosView!
    
    @IBOutlet weak var PName: UILabel!
    
    
    @IBOutlet weak var pPrice: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}