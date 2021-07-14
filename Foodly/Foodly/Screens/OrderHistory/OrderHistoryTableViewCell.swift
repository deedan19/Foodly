//
//  OrderHistoryTableViewCell.swift
//  Foodly
//
//  Created by Decagon on 24.6.21.
//

import UIKit

class OrderHistoryTableViewCell: UITableViewCell {
    static let identifier = "OrderHistoryTableViewCell"
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var itemsLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var restaurantImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with history: HistoryDetail) {
        moneyLabel.text = history.amount
        itemsLabel.text = history.itemNumber
        nameLabel.text = history.name
        restaurantImage.image = history.image
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
