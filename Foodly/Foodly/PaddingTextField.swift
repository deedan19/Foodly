//
//  PaddingTextField.swift
//  CustomLoginDemo
//
//  Created by Decagon on 31/05/2021.
//

import UIKit

class PaddingTextField: UITextField {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
            return CGRect(x: bounds.origin.x + 24, y: bounds.origin.y, width: bounds.width - 70, height: bounds.height)
        }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 24, y: bounds.origin.y, width: bounds.width, height: bounds.height)
    }
        override func editingRect(forBounds bounds: CGRect) -> CGRect {
            return CGRect(x: bounds.origin.x + 24, y: bounds.origin.y, width: bounds.width - 70, height: bounds.height)
        }
}
