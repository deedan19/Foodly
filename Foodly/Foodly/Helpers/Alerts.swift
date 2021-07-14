//
//  Alerts.swift
//  Foodly
//
//  Created by Decagon on 07/06/2021.
//

import Foundation
import UIKit

struct Alert {
    static func showBasicAlert(on viewController: UIViewController, with title: String, message: String) {
           let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        viewController.present(alert, animated: true)
    }
    
    static func showIncompleteFormAlert(on viewController: UIViewController) {
        showBasicAlert(on: viewController, with: "Incomplete Form", message: "Please fill out fields in the form")
    }
    
    static func invalidEmailAlert(on viewController: UIViewController) {
        showBasicAlert(on: viewController,
                       with: "Invalid  Email or Password",
                       message: "Please enter a valid email address")
    }
}
