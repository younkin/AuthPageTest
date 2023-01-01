//
//  RegisterView.swift
//  AuthPageTest
//
//  Created by Евгений Юнкин on 01.01.23.
//


import UIKit
import SnapKit

class RegisterView: UIViewController {
    
//    var loginButtonTap: (() -> Void)?
    
    private var loginIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "loginIcon")
        return image
    }()
    
     var emailTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = AppColors.lightGray
         textField.returnKeyType = UIReturnKeyType.done
        return textField
    }()
    
     var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = AppColors.lightGray
         textField.returnKeyType = UIReturnKeyType.done
        return textField
    }()
    
    private var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Регистрироваться", for: .normal)
        button.setTitleColor(AppColors.darkGray, for: .normal)
        button.backgroundColor = AppColors.orange
        button.setTitleColor(AppColors.brawn, for: .highlighted)
        button.addTarget(self, action: #selector(logBattonTap), for: .touchUpInside)
        return button
    }()
  
     var statusLabel: UILabel = {
      let label = UILabel()
        label.text = "введите email и пароль"
        label.textColor = AppColors.lightGray
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.darkGray
        makeConstraints()
        makeRoundedItems()
    }
  
    
    @objc func logBattonTap() {
//        loginButtonTap?()
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
        
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
    
        view.addSubview(statusLabel)
        view.addSubview(loginIcon)
        
        

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
        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(10)
            $0.width.equalTo(view.snp.width).multipliedBy(0.5)
            $0.centerX.equalTo(view.snp.centerX)
            $0.height.equalTo(30)
        }
        
      
        statusLabel.snp.makeConstraints {
            
            $0.width.equalTo(view.snp.width).multipliedBy(0.7)
            $0.centerX.equalTo(view.snp.centerX)
            $0.height.equalTo(30)
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


