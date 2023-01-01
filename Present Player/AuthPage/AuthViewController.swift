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
    private lazy var registerView = RegisterView()
    private lazy var recoveryView = RecoverView()
    
    
    // MARK: - View lifecycle
    override func loadView() {
        super.loadView()
        let view = AuthView()
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.gray
        
        hideKeyboardWhenTappedAround()
        setDelegates()
        
        loginButton()
        regButton()
        recoveryButton()
    }
    
    
    
    func setDelegates() {
        customView?.emailTextField.delegate = self
        customView?.passwordTextField.delegate = self
    }
    func regButton() {
        customView?.regButtonTapped = {
            let regView = RegisterView()
            self.present(regView, animated: true)
        }
    }
    
    func loginButton() {
        self.customView?.loginButtonTapped = {
            
            //убираем опционал и проверяем на налицие текста в мейл
            guard let emailText = self.customView?.emailTextField.text, !emailText.isEmpty else {
                self.customView?.statusLabel.text = "введите мейл"
                return
            }
            //убираем опционал и проверяем на налицие текста в пароле
            guard let passwordText = self.customView?.passwordTextField.text, !passwordText.isEmpty else {
                self.customView?.statusLabel.text = "введите пароль"
                return
            }
            
            
            // проверяем на валидность написания мейла
            if !emailText.isValidEmailAddress() {
                self.customView?.statusLabel.text = "введите правильный мейл"
                return
            }
            
            
            // проверяем на валидность написания пароля
            if !passwordText.matchesEnglishLettersAndNumbersFilter() {
                    self.customView?.statusLabel.text = "пароль из англ букв и цифр"
                    return
                }
            
            
            // запрос на сервер проверки логина
            if self.authViewModel.login(mail: emailText, password: passwordText) {
                let login = LogedInView()
                self.present(login, animated: true)
            } else {
                self.customView?.statusLabel.text = "неверный пароль"
            }
            
            
            
            
        }
    }
    
    
    func registerButton() {
        
    }
    
    
    func recoveryButton() {
        customView?.recoveryButtonTapped = {
            let recView = RecoverView()
            self.present(recView, animated: true)
        }
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

