//
//  Util.swift
//  Foodly
//
//  Created by Decagon on 06/06/2021.
//

import UIKit
import MBProgressHUD

private var aView: UIView?

extension UIViewController {
    func showIndicator(withTitle title: String) {
        let indicator = MBProgressHUD.showAdded(to: self.view, animated: true)
        indicator.label.text = title
        indicator.isUserInteractionEnabled = false
        indicator.show(animated: true)
    }
    
    func hideIndicator() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    func hideIndicatorIfNetworkOff() {
        let indicator = MBProgressHUD.showAdded(to: self.view, animated: true)
        indicator.label.text = title
        indicator.isUserInteractionEnabled = false
        indicator.hide(animated: true, afterDelay: 5)
    }
}
