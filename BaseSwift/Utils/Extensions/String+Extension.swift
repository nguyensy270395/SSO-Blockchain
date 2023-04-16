//
//  String+Extension.swift
//  SSO Blockchain
//
//  Created by Nguyễn Thanh Sỹ on 16/04/2023.
//

import Foundation

extension String {
    func isValidEmail() -> Bool {
        if self.isEmpty {
            return true
        }
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }

    func isValidPassWord() -> Bool {
        if self.isEmpty {
            return true
        }
        let passRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\dd$@$!%*?&#]{8,}$"
        let passPred = NSPredicate(format:"SELF MATCHES %@", passRegEx)
        return passPred.evaluate(with: self)
    }
}
