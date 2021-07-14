//
//  Foodly+PasswordValidation.swift
//  foodlySignUpScreen
//
//  Created by Decagon on 31/05/2021.
//

import UIKit

// MARK: - isValidEmail
extension String {
    public var isValidEmail: Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
    }
}

// MARK: - isValidPassword
public func isValidPassword(_ password: String ) -> Bool {
    let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,}$"
    return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
}

extension String {
   public var hasWhiteSpace: Bool {
      return self.contains(" ")
   }
}
