//
//  RegisterView.swift
//  AuthPageTest
//
//  Created by Евгений Юнкин on 01.01.23.
//


import UIKit
import SnapKit

class RegisterView: UIViewController {
    
    var regButtonTap: (() -> Void)?
    
    
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
    
     var emailTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = AppColors.lightGray
         textField.returnKeyType = UIReturnKeyType.done
         let attr = NSAttributedString(string: "введите мейл", attributes: [.foregroundColor: AppColors.gray])
         textField.attributedPlaceholder = attr
        return textField
    }()
    
     var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = AppColors.lightGray
         textField.returnKeyType = UIReturnKeyType.done
         let attr = NSAttributedString(string: "введите пароль", attributes: [.foregroundColor: AppColors.gray])
         textField.attributedPlaceholder = attr
        return textField
    }()
    var repeatPasswordTextField: UITextField = {
       let textField = UITextField()
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
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.darkGray
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        makeConstraints()
        makeRoundedItems()
        hideKeyboardWhenTappedAround()
        
    }
    @objc func regСonfirm() {
        regButtonTap?()
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
    }
    
    func makeConstraints() {
        view.addSubview(exitButton)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(repeatPasswordTextField)
        view.addSubview(regButton)
    
        view.addSubview(statusLabel)
        view.addSubview(loginIcon)
        
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


//MARK: hide Keyboard
extension RegisterView {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(RegisterView.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


//MARK: textField Delegate
extension RegisterView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

