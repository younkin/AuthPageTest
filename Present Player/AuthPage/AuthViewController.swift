//
//  ViewController.swift
//  AuthPageTest
//
//  Created by Евгений Юнкин on 31.12.22.
//

import UIKit
import CoreData


class AuthViewController: UIViewController {
    //    var recoverViewModel: RecoverViewModelInterface = RecoverViewModel()
    var authViewModel: AuthViewModelInterface = AuthViewModel()
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
            guard !DefaultsManager.isLoggedIn else {
                let login = LogedInViewController()
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
        
        guard let emailText = self.customView?.emailTextField.text,
              let passwordText = self.customView?.passwordTextField.text
        else {
            return
        }
        
        let inputChack = authViewModel.inputDataCheck(email: emailText, password: passwordText) { [weak self] response in
            guard let self else { return }
            switch response {
            case .failure(let failure):
                switch failure {
                case .emailSpellingMistake:
                    self.showToast(message: "Введите правильный емейл. ex: mail@mail.com")
                    break
                case .passwordSpellingMistake:
                    self.showToast(message: "Пароль должен содержать только английские буквы и цифры.")
                    break
                default:
                    break
                }
            case .success(): break
                
            }
        }
        
        guard inputChack else{return}
        self.customView?.indicator.startAnimating()
        self.customView?.loginButton.isEnabled = false
        
        self.authorization(mail: emailText, password: passwordText)
        
    }
    
    
    func authorization(mail: String, password: String) {
        authViewModel.login(mail: mail, password: password) { [weak self] response in
            guard let self = self else {
                return
            }
            self.customView?.indicator.stopAnimating()
            self.customView?.loginButton.isEnabled = true
            switch response {
            case .success:
                let login = LogedInViewController()
                self.present(login, animated: true)
            case .failure(let error):
                switch error {
                case .wrongCredentials:
                    self.showToast(message: "Неверный логин или пароль")
                case .unknown:
                    self.showToast(message: "Что-то пошло не так")
                case .connectionLost:
                    self.showToast(message: "Интернет-соединение потеряно", style: .active( { [weak self] in
                        self?.authViewModel.retry()
                    }))
                }
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



