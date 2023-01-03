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
            self.authViewModel.createUser(mail: "mail@mail.ru", password: "admin", repPassword: "admin")
            print(self.customView?.emailTextField.text)
            print(self.customView?.emailTextField.validate())
            print(self.customView?.emailTextField.state.isEmpty)
            
            //убираем опционал
            guard let emailText = self.customView?.emailTextField.text,
                  let passwordText = self.customView?.passwordTextField.text
            else {return}

            
            
            
            // проверяем на валидность написания мейла
            if !emailText.isValidEmail() {
                self.customView?.statusLabel.text = "введите правильный мейл"
                return
            }
            
            
            // проверяем на валидность написания пароля
            if !passwordText.isValidPassword() {
                    self.customView?.statusLabel.text = "пароль из англ букв и цифр"
                    return
                }
            
            
            // запрос на сервер проверки логина
            
            self.loginRequest(mail: emailText, password: passwordText)
            
        }
    }
    func loginRequest(mail: String, password: String) {
        
        if authViewModel.login(mail: mail, password: password) {
            let login = LogedInView()
            self.present(login, animated: true)
        } else {
            self.customView?.statusLabel.text = "неверный пароль"
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

