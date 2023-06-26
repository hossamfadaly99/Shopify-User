//
//  Favourite_Cell.swift
//  Shopify User
//
//  Created by MAC on 08/06/2023.
//

import UIKit
import Cosmos
class Favourite_Cell: UITableViewCell {
    @IBOutlet weak var pImg: UIImageView!
    @IBOutlet weak var pName: UILabel!
    @IBOutlet weak var pPrice: UILabel!
    
    @IBOutlet weak var ratingCosmos: CosmosView!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
