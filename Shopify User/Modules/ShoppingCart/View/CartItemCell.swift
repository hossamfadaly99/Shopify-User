//
//  CartItemCell.swift
//  Shopify User
//
//  Created by Hossam on 04/06/2023.
//

import UIKit
import Kingfisher

class CartItemCell: UITableViewCell {

  @IBOutlet weak var photoImage: UIImageView!
  @IBOutlet weak var minusBtn: UIButton!
  @IBOutlet weak var addBtn: UIButton!
  @IBOutlet weak var counterLabel: UILabel!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!

  var counter: Int = 0

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

  func loadData(item: Line_items){
    counter = Int(counterLabel.text ?? "0") ?? 0
    titleLabel.text = item.name
    priceLabel.text = "$\(item.price ?? "0")"
    counterLabel.text = "\(counter)"
    photoImage.image = UIImage(named: "product_placeholder")
  }
  @IBAction func plusBtnClick(_ sender: Any) {
    counter += 1
    counterLabel.text = "\(counter)"
  }

  @IBAction func minusBtnClick(_ sender: Any) {
    counter += -1
    counterLabel.text = "\(counter)"
  }

}
