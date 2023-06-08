//
//  AuthenticationManager.swift
//  Shopify User
//
//  Created by MAC on 08/06/2023.
//

import Foundation
class AuthenticationManager{
    
    func isEmailValid(_ email: String) -> Bool {
        // Regular expression pattern for email validation
        let emailRegex = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"

        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func isPasswordValid(_ password: String) -> Bool {
        // Password validation criteria: at least 8 characters, containing at least one uppercase letter, one lowercase letter, and one digit
        let passwordRegex = "(?=.*[A-Z])(?=.*[a-z])(?=.*\\d).{8,}"

        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }
    
    func isUsernameValid(_ username: String) -> Bool {
        // Username validation criteria: alphanumeric characters only, length between 3 and 16 characters
        let usernameRegex = "^[a-zA-Z0-9]{3,16}$"
        
        let usernamePredicate = NSPredicate(format: "SELF MATCHES %@", usernameRegex)
        return usernamePredicate.evaluate(with: username)
    }
}
