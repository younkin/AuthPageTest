//
//  ViewController.swift
//  AuthPageTest
//
//  Created by Евгений Юнкин on 31.12.22.
//

import UIKit
import CoreData


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
        setupUI()
        
        addKeyboardDismissGesture()
        loginButton()
        regButton()
        recoveryButton()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardDismissGesture()
    }
    
    func setupUI() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            guard DefaultsManager.isLogged == "" else {
                let login = LogedInView()
                self.present(login, animated: true)
                return
            }
        }
    }
    
    
    func regButton() {
        customView?.regButtonTapped = {
            let regView = RegisterViewController()
            self.present(regView, animated: true)
        }
    }
    
    func loginButton() {
        self.customView?.loginButtonTapped = {
            
            guard let emailText = self.customView?.emailTextField.text,
                  emailText.isValidEmail(),
                  !emailText.isEmpty,
                  let passwordText = self.customView?.passwordTextField.text,
                  passwordText.isValidPassword(),
                  !passwordText.isEmpty
            else {
                self.showToast(message: "Заполните все поля и убедитесь, что мейл и пароль введен верно", withButton: true)
                return
            }
            self.customView?.indicator.startAnimating()
            self.customView?.loginButton.isEnabled = false

            self.authorization(mail: emailText, password: passwordText)
        }
    }
    
    
    func authorization(mail: String, password: String) {
        authViewModel.login(mail: mail, password: password) { response in
            switch response.result {
            case .success:
                guard let token = response.token else {return}
                DefaultsManager.isLogged = token
                let login = LogedInView()
                self.present(login, animated: true)
                self.customView?.indicator.stopAnimating()
                self.customView?.loginButton.isEnabled = true
            case .fail:
                self.showToast(message: "Не верный пароль")
                self.customView?.indicator.stopAnimating()
                self.customView?.loginButton.isEnabled = true
            case .connectionFail:
                self.showToast(message: "Чтото пошло не так")
                self.customView?.indicator.stopAnimating()
                self.customView?.loginButton.isEnabled = true
            default:
                self.customView?.indicator.stopAnimating()
                self.customView?.loginButton.isEnabled = true
                break
            }
        }
    }
    
    func recoveryButton() {
        customView?.recoveryButtonTapped = {
            let recView = RecoverViewController()
            self.present(recView, animated: true)
        }
    }
}



