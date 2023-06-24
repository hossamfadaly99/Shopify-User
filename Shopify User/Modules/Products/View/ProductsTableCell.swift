//
//  ProductsTableCell.swift
//  Shopify User
//
//  Created by Mac on 14/06/2023.
//

import UIKit

class ProductsTableCell: UITableViewCell {

    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var productTypeLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productImg: UIImageView!
    var delegate:ClickToFavBtnDelegate?
    var cellIndex: Int?
   // var onclickOnFavBtn : (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func addToFavBtn(_ sender: Any) {
        delegate?.clicked(cellIndex!)
    }
    func setFavUI(isFav:Bool){
            var image:UIImage!
            if isFav{
                 image = UIImage(systemName: "heart.fill")
                 favBtn.setImage(image, for: .normal)
                
            }else{
                 image = UIImage(systemName: "heart")
                 favBtn.setImage(image, for: .normal)
            }
           
        }
    
}
