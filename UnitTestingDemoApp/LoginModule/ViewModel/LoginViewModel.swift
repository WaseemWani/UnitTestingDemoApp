//
//  LoginViewModel.swift
//  UnitTestinDemoApp
//
//  Created by Waseem Wani on 25/01/23.
//

import Foundation


class LoginViewModel {
    var isValidEmail = true
    var isValidPassword = true
    
    func login(email: String, password: String) -> LoginResponse {
        if !isValid(email: email) {
            return LoginResponse(shouldAllowLogin: false, errorMessage: "Invalid email")
        } else if !isValid(password: password) {
            return LoginResponse(shouldAllowLogin: false, errorMessage: "Invalid passsword")
        } else if isValid(email: email) && isValid(password: password) {
            return LoginResponse(shouldAllowLogin: true, errorMessage: nil)
        } else {
            return LoginResponse(shouldAllowLogin: false, errorMessage: "Invalid credentials")
        }
    }
    
    private func isValid(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        isValidEmail = NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
        return isValidEmail
    }
    
    private func isValid(password: String) -> Bool {
        let trimmedPswd = password.trimmingCharacters(in: CharacterSet.whitespaces)
        let passwordRegx = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&<>*~:`-]).{8,}$"
        let passwordCheck = NSPredicate(format: "SELF MATCHES %@",passwordRegx)
        isValidPassword = passwordCheck.evaluate(with: trimmedPswd)
        return isValidPassword
    }
}
