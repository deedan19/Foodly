//
//  MoreDetailsTableViewCell.swift
//  Foodly
//
//  Created by Decagon on 22/06/2021.
//

import UIKit

class MoreDetailsTableViewCell: UITableViewCell {
    
    var titleArray: [String] = []
    var amountArray: [String] = []
    var foodQuantity = "1"
  
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var foodTypeLabel: UILabel!
    @IBOutlet weak var foodAmountLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var addLabel: UILabel!
    @IBOutlet weak var addOutlet: UIButton!
    
    weak var delegate: DetailsTableViewCellDelegate?
    
    static let identifier = String(describing: MoreDetailsTableViewCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addButton.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: MoreDetailsTableViewCell.identifier, bundle: nil)
    }
    
    public func configure(with model: DetailModel) {
        restaurantNameLabel.text = model.title
        foodTypeLabel.text = model.type
        foodAmountLabel.text = model.amount
        myImageView.image = UIImage(named: model.image)
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        if addLabel.text == "Add" {
            delegate?.didTapAddBtn(with: foodTypeLabel.text!, and: foodAmountLabel.text!, and: myImageView.image!, and: foodQuantity)
            addOutlet.setImage(UIImage(systemName: "checkmark"), for: .normal)
            addOutlet.tintColor = UIColor.white
            addButton.backgroundColor = #colorLiteral(red: 0.4254465997, green: 0.3577132225, blue: 0.9634798169, alpha: 1)
            addLabel.text = "Added"
            addLabel.textColor = UIColor.white
        } else {
            delegate?.didTapRemoveBtn(with: foodTypeLabel.text!, and: foodAmountLabel.text!, and: myImageView.image!, and: foodQuantity)
            addOutlet.setImage(UIImage(systemName: "plus"), for: .normal)
            addOutlet.tintColor = #colorLiteral(red: 0.4847761393, green: 0.425460428, blue: 0.9666016698, alpha: 1)
            addLabel.textColor = UIColor(named: "FoodlyLargeLabelColorMode")
            addLabel.text = "Add"
            addButton.backgroundColor = UIColor(named: "AddButtonBgColor")
            
        }
        
    }}
