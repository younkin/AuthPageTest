//
//  LogedInView.swift
//  AuthPageTest
//
//  Created by Евгений Юнкин on 01.01.23.
//


import UIKit
import SnapKit

class LogedInView: UIViewController {
    
//    var loginButtonTap: (() -> Void)?
    
    private var loginIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "loginIcon")
        return image
    }()
    
    
    private var logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("выйти", for: .normal)
        button.setTitleColor(AppColors.darkGray, for: .normal)
        button.backgroundColor = AppColors.orange
        button.setTitleColor(AppColors.brawn, for: .highlighted)
        button.addTarget(self, action: #selector(logoutButtonTap), for: .touchUpInside)
        return button
    }()
  
     var statusLabel: UILabel = {
      let label = UILabel()
        label.text = "Вы успешно авторизировались"
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
  
    
    @objc func logoutButtonTap() {
//        loginButtonTap?()
        DefaultsManager.isLogged = ""
        dismiss(animated: true)
    }
    
    func makeRoundedItems() {
        
        logoutButton.layer.cornerRadius = min(logoutButton.layer.frame.width , logoutButton.layer.frame.height) / 2
        logoutButton.layer.masksToBounds = true
        
    }
    
    func makeConstraints() {
        
        view.addSubview(logoutButton)
        view.addSubview(statusLabel)
        view.addSubview(loginIcon)
        
        

        logoutButton.snp.makeConstraints {
            $0.center.equalTo(view.snp.center)
            $0.height.equalTo(30)
            $0.width.equalTo(view.snp.width).multipliedBy(0.7)
        }
      
        statusLabel.snp.makeConstraints {
            
            $0.width.equalTo(view.snp.width).multipliedBy(0.7)
            $0.centerX.equalTo(view.snp.centerX)
            $0.height.equalTo(30)
            $0.bottom.equalTo(logoutButton.snp.top).offset(-20)
        }
        
        loginIcon.snp.makeConstraints {
            $0.width.equalTo(view.snp.width).multipliedBy(0.5)
            $0.height.equalTo(view.snp.width).multipliedBy(0.5)
            $0.centerX.equalTo(view.snp.centerX)
            $0.bottom.equalTo(statusLabel.snp.top).offset(-40)
        }
        
  
    }
   
    
}




