//
//  CartTableViewCell.swift
//  Foodly
//
//  Created by Decagon on 16/06/2021.
//

import UIKit

protocol CartTableViewCellDelegate: AnyObject {
    func addBtnTapped(sender: CartTableViewCell, on plus: Bool)
    func minusBtnTapped(sender: CartTableViewCell, on plus: Bool)
}

class CartTableViewCell: UITableViewCell {
    @IBOutlet private weak var restaurantImage: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var itemCountLabel: UILabel!
    @IBOutlet private weak var addButton: UIButton!
    @IBOutlet private weak var minusButton: UIButton!
    @IBOutlet private weak var priceLabel: UILabel!

    weak var delegate: CartTableViewCellDelegate?
    
    var tableViewModel = CartViewModel()
    var oldAmount = [Float]()
    
    public func configureCart(with model: CartModel) {
        itemCountLabel.text = model.itemNumber
        nameLabel.text = model.itemName
        priceLabel.text = "$\(model.itemPrice)"
        restaurantImage.image = model.itemImage
    }
    
    @IBAction func toAddItem(_ sender: Any) {
        if let delegate = delegate {
            delegate.addBtnTapped(sender: self, on: true)
        }
    }
    
    @IBAction func toMinusItem(_ sender: Any) {
        if let delegate = delegate {
            delegate.addBtnTapped(sender: self, on: false)
        }
    }
}
