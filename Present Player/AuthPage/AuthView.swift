//
//  AuthView.swift
//  AuthPageTest
//
//  Created by Евгений Юнкин on 31.12.22.
//

import Foundation
import UIKit
import SnapKit

//enum StatusState: String {
//    case greating = "Вы успешно вошли"
//    case wrongMail = ""
//    case emptyMail = ""
//    case emptyPassword = ""
//}

class AuthView: UIView {
    
    var loginButtonTapped: (() -> Void)?
    var regButtonTapped: (() -> Void)?
    var recoveryButtonTapped: (() -> Void)?
    
    
    private var loginIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "loginIcon")
        return image
    }()
    
     var emailTextField: EmailTextField = {
        let textField = EmailTextField()
        textField.backgroundColor = AppColors.lightGray
         textField.returnKeyType = UIReturnKeyType.done
         let attr = NSAttributedString(string: "имейл", attributes: [.foregroundColor: AppColors.gray])
         textField.attributedPlaceholder = attr
        return textField
    }()
    
     var passwordTextField: PasswordTextField = {
        let textField = PasswordTextField()
        textField.backgroundColor = AppColors.lightGray
         textField.returnKeyType = UIReturnKeyType.done
         let attr = NSAttributedString(string: "пароль", attributes: [.foregroundColor: AppColors.gray])
         textField.attributedPlaceholder = attr
        return textField
    }()
    
    private var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Авторизироваться", for: .normal)
        button.setTitleColor(AppColors.darkGray, for: .normal)
        button.backgroundColor = AppColors.orange
        button.setTitleColor(AppColors.brawn, for: .highlighted)
        button.addTarget(self, action: #selector(logBattonTap), for: .touchUpInside)
        return button
    }()
    
    private var resetPassword: UIButton = {
        let button = UIButton()
        button.setTitle("Забыли пароль?", for: .normal)
        button.setTitleColor(AppColors.lightGray, for: .normal)
        button.setTitleColor(AppColors.brawn, for: .highlighted)
        button.addTarget(self, action: #selector(recoveryButtonTap), for: .touchUpInside)

        return button
    }()
    private var regButton: UIButton = {
        let button = UIButton()
        button.setTitle("Регистрация", for: .normal)
        button.setTitleColor(AppColors.lightGray, for: .normal)
        button.setTitleColor(AppColors.brawn, for: .highlighted)
        button.addTarget(self, action: #selector(regButtonTap), for: .touchUpInside)
        
        return button
    }()
    
     var statusLabel: UILabel = {
      let label = UILabel()
        label.text = "введите email и пароль"
        label.textColor = AppColors.darkGray
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    
    init() {
        super.init(frame: .zero)
        
        makeConstraints()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        makeRoundedItems()
      
    }
    
    @objc func logBattonTap() {
        loginButtonTapped?()
    }
    
    @objc func regButtonTap() {
        regButtonTapped?()
    }
    @objc func recoveryButtonTap() {
        recoveryButtonTapped?()
    }
    
    
    func makeRoundedItems() {
        
        loginButton.layer.cornerRadius = min(loginButton.layer.frame.width , loginButton.layer.frame.height) / 2
        loginButton.layer.masksToBounds = true
        
       
        emailTextField.layer.cornerRadius = min(emailTextField.layer.frame.width , emailTextField.layer.frame.height) / 8
        emailTextField.layer.masksToBounds = true
        
        
        passwordTextField.layer.cornerRadius = min(passwordTextField.layer.frame.width , passwordTextField.layer.frame.height) / 8
        passwordTextField.layer.masksToBounds = true
    }
    
    func makeConstraints() {
        
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(loginButton)
       
        addSubview(resetPassword)
        addSubview(regButton)
        addSubview(statusLabel)
        addSubview(loginIcon)
        
        

        emailTextField.snp.makeConstraints {
            $0.center.equalTo(self.snp.center)
            $0.height.equalTo(30)
            $0.width.equalTo(self.snp.width).multipliedBy(0.7)
        }
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).inset(-10)
            $0.centerX.equalTo(self.snp.centerX)
            $0.height.equalTo(30)
            $0.width.equalTo(self.snp.width).multipliedBy(0.7)
        }
        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(10)
            $0.width.equalTo(self.snp.width).multipliedBy(0.5)
            $0.centerX.equalTo(self.snp.centerX)
            $0.height.equalTo(30)
        }
        
        resetPassword.snp.makeConstraints {
            
            $0.width.equalTo(self.snp.width).multipliedBy(0.4)
            $0.left.equalTo(self.snp.left).offset(20)
            $0.height.equalTo(30)
            $0.bottom.equalTo(self.snp.bottom).offset(-200)
        }
        regButton.snp.makeConstraints {
            
            $0.width.equalTo(self.snp.width).multipliedBy(0.4)
            $0.right.equalTo(self.snp.right).offset(-20)
            $0.height.equalTo(30)
            $0.bottom.equalTo(self.snp.bottom).offset(-200)
        }
        statusLabel.snp.makeConstraints {
            
            $0.width.equalTo(self.snp.width).multipliedBy(0.7)
            $0.centerX.equalTo(self.snp.centerX)
            $0.height.equalTo(60)
            $0.bottom.equalTo(emailTextField.snp.top).offset(-20)
        }
        
        loginIcon.snp.makeConstraints {
            $0.width.equalTo(self.snp.width).multipliedBy(0.5)
            $0.height.equalTo(self.snp.width).multipliedBy(0.5)
            $0.centerX.equalTo(self.snp.centerX)
            $0.bottom.equalTo(statusLabel.snp.top).offset(-40)
        }
        
  
    }
   
    
}

