//
//  LoginViewModel.swift
//  Foodly
//
//  Created by Decagon on 09/06/2021.
//

import Foundation

import UIKit

class LoginViewModel {
    
   
    func loginUser(with email: String, password: String, completion: @escaping ((Bool) -> Void)) {
        let manager = AuthManager()
        manager.validateLogin(with: email, password: password) { success in
            completion(success)
        }
    }
    
}
