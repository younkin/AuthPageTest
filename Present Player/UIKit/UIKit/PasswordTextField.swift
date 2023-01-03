//
//  PasswordTextField.swift
//  AuthPageTest
//
//  Created by Евгений Юнкин on 03.01.23.
//

import UIKit

class PasswordTextField: UITextField {

    override init(frame: CGRect) {
           super.init(frame: frame)
           setupTextField()
       }
       
       required init?(coder: NSCoder) {
           super.init(coder: coder)
           setupTextField()
       }
       
       private func setupTextField() {
           self.isSecureTextEntry = true
           self.autocapitalizationType = .none
       }
  var password: String? {
    get {
      return self.text
    }
    set {
      self.text = newValue
    }
  }
  
  
  func validate() -> Bool {
    guard let password = password else { return false }
      return password.isValidEmail()
  }
}
