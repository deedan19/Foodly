//
//  MenuTableViewCell.swift
//  Foodly
//
//  Created by mac on 10/06/2021.
//

import UIKit

protocol MenuTableViewCellDelegate: AnyObject {
    func seeMore(with title: String)
}

class MenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var searchBtn: UIButton!
    
    static let identifier = String(describing: MenuTableViewCell.self)
    
    weak var menuDelegate: MenuTableViewCellDelegate?
    
    static func nib() -> UINib {
        return UINib(nibName: MenuTableViewCell.identifier, bundle: nil)
    }
    
    public func configure(with model: MealsModel) {
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
 
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func seeMoreButton(_ sender: UIButton) {
        menuDelegate?.seeMore(with: "See More")
    }
    
}
