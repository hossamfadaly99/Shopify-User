//
//  SearchCell.swift
//  Shopify User
//
//  Created by MAC on 22/06/2023.
//

import UIKit

class SearchCell: UITableViewCell {

    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var productTypeLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productImg: UIImageView!
    //var delegate:ActionDelegate?
    var viewModel = SearchViewModel()
    var cellIndex: Int?
   // var onclickOnFavBtn : (() -> ())?
    private var product: Product?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func addToFavBtn(_ sender: Any) {
        print("yaaaaal")
       // viewModel.favoriteButtonTapped.onNext(cellIndex)
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
