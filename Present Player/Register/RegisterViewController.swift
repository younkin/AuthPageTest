//
//  RegisterView.swift
//  AuthPageTest
//
//  Created by Евгений Юнкин on 01.01.23.
//


import UIKit
import SnapKit

class RegisterViewController: UIViewController {
    
    
    var registerViewModel: RegisterViewModelInterface = RegisterViewModel()
    let indicator = UIActivityIndicatorView(style: .medium)
    
    private var loginIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "loginIcon")
        return image
    }()
    
    private var exitButton: UIButton = {
        let button = UIButton(type: .close)
        button.setTitleColor(AppColors.lightGray, for: .normal)
        button.addTarget(self, action: #selector(exitTapped), for: .touchUpInside)
        return button
    }()
    
    var emailTextField: EmailTextField = {
        let textField = EmailTextField()
        textField.backgroundColor = AppColors.lightGray
        textField.returnKeyType = UIReturnKeyType.done
        let attr = NSAttributedString(string: "введите мейл", attributes: [.foregroundColor: AppColors.gray])
        textField.attributedPlaceholder = attr
        return textField
    }()
    
    var passwordTextField: PasswordTextField = {
        let textField = PasswordTextField()
        textField.backgroundColor = AppColors.lightGray
        textField.returnKeyType = UIReturnKeyType.done
        let attr = NSAttributedString(string: "введите пароль", attributes: [.foregroundColor: AppColors.gray])
        textField.attributedPlaceholder = attr
        return textField
    }()
    var repeatPasswordTextField: PasswordTextField = {
        let textField = PasswordTextField()
        textField.backgroundColor = AppColors.lightGray
        textField.returnKeyType = UIReturnKeyType.done
        let attr = NSAttributedString(string: "повторите пароль", attributes: [.foregroundColor: AppColors.gray])
        textField.attributedPlaceholder = attr
        return textField
    }()
    
    private var regButton: UIButton = {
        let button = UIButton()
        button.setTitle("Регистрироваться", for: .normal)
        button.setTitleColor(AppColors.darkGray, for: .normal)
        button.backgroundColor = AppColors.orange
        button.setTitleColor(AppColors.brawn, for: .highlighted)
        button.addTarget(self, action: #selector(regСonfirm), for: .touchUpInside)
        return button
    }()
    
    var statusLabel: UILabel = {
        let label = UILabel()
        label.text = "введите email и пароль"
        label.textColor = AppColors.lightGray
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.darkGray
        
        addKeyboardDismissGesture()
        makeConstraints()
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardDismissGesture()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        makeRoundedItems()
    }
    
    @objc func regСonfirm() {
        guard let emailText = emailTextField.text,
              let passwordText = passwordTextField.text,
              let repPasswordText = repeatPasswordTextField.text
        else {
            return
        }
        
        let inputChack = registerViewModel.inputDataCheck(email: emailText, password: passwordText, repPassword: repPasswordText) { [weak self] response in
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
                case .passwordReplicaIncorrect:
                    self.showToast(message: "Пароли не совпадают")
                default:
                    break
                }
            case .success(): break
                
            }
        }
        
        guard inputChack else{return}
        
        self.indicator.startAnimating()
        self.regButton.isEnabled = false
        
        registerViewModel.createUser(mail: emailText, password: passwordText, repPassword: repPasswordText) { [weak self] response in
            guard let self else { return }
            self.indicator.stopAnimating()
            self.regButton.isEnabled = true
            switch response {
            case .success:
                self.showToast(message: "Вы зарегистрировались")
                
            case .failure(let failure):
                switch failure {
                case .duplicateUser:
                    self.showToast(message: "такой юзер существует")
                case .networkError:
                    self.showToast(message: "Интернет-соединение потеряно", style: .active( { [weak self] in
                        self?.registerViewModel.retry()
                    }))
                case .unknown:
                    self.showToast(message: "Что-то пошло не так")
                default:
                    break
                }
            }
        }
    }
    
    
    @objc func exitTapped() {
        
        dismiss(animated: true)
    }
    
    func makeRoundedItems() {
        
        regButton.layer.cornerRadius = min(regButton.layer.frame.width , regButton.layer.frame.height) / 2
        regButton.layer.masksToBounds = true
        
        
        emailTextField.layer.cornerRadius = min(emailTextField.layer.frame.width , emailTextField.layer.frame.height) / 8
        emailTextField.layer.masksToBounds = true
        
        
        passwordTextField.layer.cornerRadius = min(passwordTextField.layer.frame.width , passwordTextField.layer.frame.height) / 8
        passwordTextField.layer.masksToBounds = true
        
        repeatPasswordTextField.layer.cornerRadius = min(repeatPasswordTextField.layer.frame.width , repeatPasswordTextField.layer.frame.height) / 8
        repeatPasswordTextField.layer.masksToBounds = true
    }
    
    func makeConstraints() {
        view.addSubview(exitButton)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(repeatPasswordTextField)
        view.addSubview(regButton)
        view.addSubview(indicator)
        view.addSubview(statusLabel)
        view.addSubview(loginIcon)
        
        indicator.snp.makeConstraints {
            $0.center.equalTo(regButton.snp.center)
            $0.height.width.equalTo(30)
        }
        exitButton.snp.makeConstraints {
            $0.top.equalTo(view.snp.top).offset(20)
            $0.right.equalTo(view.snp.right).offset(-20)
            $0.height.equalTo(30)
            $0.width.equalTo(30)
        }
        
        emailTextField.snp.makeConstraints {
            $0.center.equalTo(view.snp.center)
            $0.height.equalTo(30)
            $0.width.equalTo(view.snp.width).multipliedBy(0.7)
        }
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).inset(-10)
            $0.centerX.equalTo(view.snp.centerX)
            $0.height.equalTo(30)
            $0.width.equalTo(view.snp.width).multipliedBy(0.7)
        }
        repeatPasswordTextField.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).inset(-10)
            $0.centerX.equalTo(view.snp.centerX)
            $0.height.equalTo(30)
            $0.width.equalTo(view.snp.width).multipliedBy(0.7)
        }
        regButton.snp.makeConstraints {
            $0.top.equalTo(repeatPasswordTextField.snp.bottom).offset(10)
            $0.width.equalTo(view.snp.width).multipliedBy(0.5)
            $0.centerX.equalTo(view.snp.centerX)
            $0.height.equalTo(30)
        }
        
        
        statusLabel.snp.makeConstraints {
            
            $0.width.equalTo(view.snp.width).multipliedBy(0.7)
            $0.centerX.equalTo(view.snp.centerX)
            $0.height.equalTo(100)
            $0.bottom.equalTo(emailTextField.snp.top).offset(-20)
        }
        
        loginIcon.snp.makeConstraints {
            $0.width.equalTo(view.snp.width).multipliedBy(0.5)
            $0.height.equalTo(view.snp.width).multipliedBy(0.5)
            $0.centerX.equalTo(view.snp.centerX)
            $0.bottom.equalTo(statusLabel.snp.top).offset(-40)
        }
        
        
    }
    
    
}




