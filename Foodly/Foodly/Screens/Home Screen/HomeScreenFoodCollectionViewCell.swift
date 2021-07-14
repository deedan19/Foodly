//
//  HomeScreenFoodCollectionViewCell.swift
//  Foodly
//
//  Created by Decagon on 05/06/2021.
//

import UIKit

class HomeScreenFoodCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: HomeScreenFoodCollectionViewCell.self)

    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    func setup(category: DishCategory) {
        categoryLabel.text = category.name
        categoryImage.image = category.image
    }
    
}
