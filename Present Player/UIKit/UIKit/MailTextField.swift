//
//  MailTextField.swift
//  AuthPageTest
//
//  Created by Евгений Юнкин on 03.01.23.
//

import UIKit

class EmailTextField: UITextField {
    
  var password: String? {
    get {
      return self.text
    }
    set {
      self.text = newValue
    }
  }
    
    override init(frame: CGRect) {
           super.init(frame: frame)
           setupTextField()
       }
       
       required init?(coder: NSCoder) {
           super.init(coder: coder)
           setupTextField()
       }
       
       private func setupTextField() {
           self.autocapitalizationType = .none
       }
  
  
  func validate() -> Bool {
    guard let email = password else { return false }
      return email.isValidEmail()
  }
    
  
}






