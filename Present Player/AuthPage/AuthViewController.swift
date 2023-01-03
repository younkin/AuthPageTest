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

 
    
    
    // MARK: - View lifecycle
    override func loadView() {
        super.loadView()
        let view = AuthView()
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.gray
        addKeyboardDismissGesture()
       
        
        loginButton()
        regButton()
        recoveryButton()
    }
    override func viewWillDisappear(_ animated: Bool) {
          super.viewWillDisappear(animated)
          removeKeyboardDismissGesture()
      }
    
    

    func regButton() {
        customView?.regButtonTapped = {
            let regView = RegisterViewController()
            self.present(regView, animated: true)
        }
    }
    
    func loginButton() {
        self.customView?.loginButtonTapped = {
//            self.showToast(message: "чтото пошло не так")
            

            
//            print(self.customView?.emailTextField.text)
//            print(self.customView?.emailTextField.validate())
//            print(self.customView?.emailTextField.state.isEmpty)
            
            guard let emailText = self.customView?.emailTextField.text,
                  emailText.isValidEmail(),
                  !emailText.isEmpty,
                  let passwordText = self.customView?.passwordTextField.text,
                  passwordText.isValidPassword(),
                  !passwordText.isEmpty
            else {
                self.customView?.statusLabel.text = "заполните все поля и убедитесь, что мейл и пароль введен верно"
                return
            }

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
            let recView = RecoverViewController()
            self.present(recView, animated: true)
        }
    }
    
    
    
    
    
}



