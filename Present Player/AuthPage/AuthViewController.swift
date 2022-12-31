//
//  ViewController.swift
//  AuthPageTest
//
//  Created by Евгений Юнкин on 31.12.22.
//

import UIKit
import CoreData

struct EnteredData {
    var mail: String
    var password: String
}

class AuthViewController: UIViewController {
    
    var authViewModel = AuthViewModel()
    private lazy var customView = self.view as? AuthView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.gray
        
        hideKeyboardWhenTappedAround()
        setDelegates()
        
        loginButton()
    }
    
    
    func setDelegates() {
        customView?.emailTextField.delegate = self
        customView?.passwordTextField.delegate = self
    }
    
    func loginButton() {
        customView?.loginButtonTap = {
            if self.customView?.emailTextField.text == "" {
                self.customView?.statusLabel.text = "введите мейл"
                return
            }
            if self.customView?.passwordTextField.text == "" {
                self.customView?.statusLabel.text = "введите пароль"
                return
            }
          
            print("tap")
        }
    }
    
    // MARK: - View lifecycle
    override func loadView() {
        super.loadView()
        let view = AuthView()
        self.view = view
    }
    
}
//MARK: hide Keyboard 
extension AuthViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(AuthViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
//MARK: textField Delegate
extension AuthViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

