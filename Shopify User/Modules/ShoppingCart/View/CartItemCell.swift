//
//  CartItemCell.swift
//  Shopify User
//
//  Created by Hossam on 04/06/2023.
//

import UIKit
import Kingfisher
import PKHUD

class CartItemCell: UITableViewCell {

  @IBOutlet weak var photoImage: UIImageView!
  @IBOutlet weak var minusBtn: UIButton!
  @IBOutlet weak var addBtn: UIButton!
  @IBOutlet weak var counterLabel: UILabel!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!

  var counter: Int = 0
  var availableQuantity = 1
  var minQuantity = 1
  var maxQuantity: Int {
    if ((availableQuantity / 3) > 0) {
      return availableQuantity / 3
    }
    else{
      return 1
    }
  }
  var price = 0.00
  var itemPrice: Double {
    return price * Double(counter)
  }
  var getTotalPrice: ()->() = {}
  var initialTotalPrice = 0.0
  var totalPrice: Double = 0
  var isPriceChanged: Bool = false  {
    didSet{
      print("ay haga in cell")
      getTotalPrice()
    }
  }
  var isLastItem: Bool = false
  var deleteThisItem: ()->() = {}
  var vc: UIViewController!

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
    counter = item.quantity ?? 0
    price = Double(item.price ?? "1.00") ?? 1.00
    print("krgkyrktktr")
    print(item.properties?.count)
    availableQuantity = 30//Int(item.properties?[1].value ?? "1") ?? 1

    titleLabel.text = item.name?.components(separatedBy: "-").first
    priceLabel.text = String(format: "%.2f \(currencySymbol)", currencyValue * price * Double(item.quantity ?? 1))

    counterLabel.text = "\(counter)"
    photoImage.kf.setImage(with: URL(string: item.properties?.first?.value ?? "product_placeholder"))
    manageQuantity()
    HUD.hide(animated: true)

  }
  @IBAction func plusBtnClick(_ sender: Any) {
    changeQuantity(operation: "+")
  }

  @IBAction func minusBtnClick(_ sender: Any) {
    if isLastItem{

      self.deleteThisItem()

    } else {
      changeQuantity(operation: "-")
    }
  }

  func changeQuantity(operation: String){
    HUD.show(.labeledProgress(title: nil, subtitle: "loading"))
    initialTotalPrice = totalPrice - itemPrice
    if operation == "+" {counter += 1} else { counter -= 1 }
    totalPrice = initialTotalPrice + itemPrice
    isPriceChanged.toggle()
  }

  func manageQuantity(){
    print(counter)
    print(minQuantity)
    if counter == minQuantity{
      let imggg = UIImage(systemName: "trash")?.withTintColor(.red, renderingMode: .alwaysOriginal)
      minusBtn.setImage(imggg!.withConfiguration(UIImage.SymbolConfiguration(scale: .medium)) , for: .normal)
      isLastItem = true
    } else {

      let imggg = UIImage(systemName: "minus")?.withTintColor(UIColor(named: "gray_9B")!)
      minusBtn.setImage(imggg!.withConfiguration(UIImage.SymbolConfiguration(scale: .medium)) , for: .normal)
      isLastItem = false
    }

    if counter == maxQuantity{
      addBtn.isEnabled = false
    } else {
      addBtn.isEnabled = true
    }
  }

}

extension UIButton{

    func setImageTintColor(_ color: UIColor) {
        let tintedImage = self.imageView?.image?.withRenderingMode(.alwaysTemplate)
        self.setImage(tintedImage, for: .normal)
        self.tintColor = color
    }

}
