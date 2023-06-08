//
//  CartItemCell.swift
//  Shopify User
//
//  Created by Hossam on 04/06/2023.
//

import UIKit

class CartItemCell: UITableViewCell {

  @IBOutlet weak var photoImage: UIImageView!
  @IBOutlet weak var minusBtn: UIButton!
  @IBOutlet weak var addBtn: UIButton!
  @IBOutlet weak var counterLabel: UILabel!
  @IBOutlet weak var titleLabel: UILabel!

  @IBOutlet weak var priceLabel: UILabel!
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

  override func layoutSubviews() {
      super.layoutSubviews()

      contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0))
  }

  private func makeBtnShadow(layer: CALayer){
    layer.shadowRadius = 0.5
    layer.shadowColor = UIColor.gray.cgColor
    layer.masksToBounds = false
    layer.shadowOpacity = 1
    layer.shadowOffset = CGSizeMake(0, 0.2)
  }

  func setupUI(){
    makeBtnShadow(layer: minusBtn.layer)
    makeBtnShadow(layer: addBtn.layer)
  }

}
