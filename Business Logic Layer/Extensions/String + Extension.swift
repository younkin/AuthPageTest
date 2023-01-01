//
//  String + Extension.swift
//  AuthPageTest
//
//  Created by Евгений Юнкин on 02.01.23.
//

import Foundation

extension String {
    func matchesEnglishLettersAndNumbersFilter() -> Bool {
        let allowedCharacters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let characterSet = CharacterSet(charactersIn: allowedCharacters)
        let filteredCharacters = self.components(separatedBy: characterSet.inverted).joined()
        return filteredCharacters == self
    }
}

extension String {
    func isValidEmailAddress() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        if self.range(of: emailRegex, options: .regularExpression) != nil {
            return true
        } else {
            return false
        }
    }
}
