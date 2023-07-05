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
    
    override var frame: CGRect{
        get{
            return super.frame
        }
        set(newFrame){
            var frame = newFrame
            frame.origin.x += 8
            frame.size.width -= 2 * 8
            frame.origin.y += 8
            frame.size.height -= 2 * 8
            super.frame = frame
        }
        
    }

}
