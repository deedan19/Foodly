//
//  ImageTableViewCell.swift
//  Foodly
//
//  Created by mac on 09/06/2021.
//

import UIKit

protocol ImageTableViewCellDelegate: AnyObject {
    func seeMore(with title: String)
}

class ImageTableViewCell: UITableViewCell {

    @IBOutlet var myImageView: UIImageView!
    @IBOutlet var largeLabel: UILabel!
    @IBOutlet var smallLabel: UILabel!
    @IBOutlet weak var seeMoreButton: UIButton!
    
    static let identifier = "ImageTableViewCell"
    
    var delegate: ImageTableViewCellDelegate?
    
    static func nib() -> UINib {
        return UINib(nibName: "ImageTableViewCell", bundle: nil)
    }
    
    func setUp(with model: Restaurants) {
        myImageView.image = model.restaurantImage
        largeLabel.text = model.restaurantName
        smallLabel.text = model.category
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func seeMoreBtnTapped(_ sender: Any) {
        delegate?.seeMore(with: "See More")
    }
    
}
