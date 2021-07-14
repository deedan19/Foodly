//
//  RestaurantsTableViewCell.swift
//  Foodly
//
//  Created by Decagon on 09/06/2021.
//

import UIKit

class RestaurantsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var restaurantLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
   
    @IBOutlet weak var mainFoodLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    
    func setup(with restaurant: Restaurants) {
        restaurantImageView.image = restaurant.restaurantImage
        restaurantLabel.text = restaurant.restaurantName
        mainFoodLabel.text = restaurant.category
        discountLabel.text = (restaurant.discountLabel+"% OFF")
       timeLabel.text = restaurant.timeLabel
        
    }
    
}
