//
//  Utilites.swift
//  CustomLoginDemo
//
//  Created by Decagon on 01/06/2021.
//

import Foundation
import UIKit

class Utilities {
    
    static func isPasswordValid(_ password: String) -> Bool {
        let regx: String = "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", regx)
        return passwordTest.evaluate(with: password)
    }
    
}
