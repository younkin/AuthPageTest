//
//  UIViewController + ext.swift
//  AuthPageTest
//
//  Created by Евгений Юнкин on 04.01.23.
//

import UIKit
import SnapKit
//MARK: тост нотификация
extension UIViewController {
    
    func showToast(message: String, withButton: Bool = false) {
        
       lazy var toastView: UIView = {
            let toast = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 50))
            toast.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            toast.layer.cornerRadius = 10
            toast.alpha = 0.0
            return toast
        }()
        
        lazy var toastLabel: UILabel = {
            let label = UILabel(frame: CGRect(x: 10, y: 10, width: 240, height: 30))
            label.text = message
            label.textColor = AppColors.lightGray
            label.textAlignment = .left
            label.numberOfLines = 0
            label.adjustsFontSizeToFitWidth = true
            return label
        }()

        lazy var tryAgainButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Try Again", for: .normal)
            button.setTitleColor(AppColors.orange, for: .normal)
            button.addTarget(self, action: #selector(tryAgainButtonTapped), for: .touchUpInside)
            button.isHidden = true
            button.titleLabel?.adjustsFontSizeToFitWidth = true
            return button
        }()
        
        toastView.addSubview(toastLabel)
        toastView.addSubview(tryAgainButton)
        self.view.addSubview(toastView)
        
        
        if withButton {
            tryAgainButton.isHidden = false
        }
        
        toastView.snp.makeConstraints {
            $0.leading.equalTo(self.view.snp.leading).offset(20)
            $0.trailing.equalTo(self.view.snp.trailing).offset(-20)
            $0.bottom.equalTo(self.view.snp.bottom).offset(-40)
            $0.height.equalTo(100)
        }

        toastLabel.snp.makeConstraints {
            $0.leading.equalTo(toastView.snp.leading).offset(10)
            $0.trailing.equalTo(tryAgainButton.snp.leading).offset(-10)
            $0.top.equalTo(toastView.snp.top).offset(10)
            $0.bottom.equalTo(toastView.snp.bottom).offset(-10)
        }

        tryAgainButton.snp.makeConstraints {
            $0.trailing.equalTo(toastView.snp.trailing).offset(-10)
            $0.centerY.equalTo(toastView.snp.centerY)
            $0.width.equalTo(50)
            $0.height.equalTo(30)
        }
        
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseOut, animations: {
                    toastView.alpha = 1.0
                }, completion: {(isCompleted) in
                    hideToast()
                })
        
        func hideToast() {
            UIView.animate(withDuration: 3.0, delay: 2.0, options: .curveEaseOut, animations: {
                toastView.alpha = 0.0
            }, completion: {(isCompleted) in
                toastView.removeFromSuperview()
            })
        }
    }

    @objc func tryAgainButtonTapped() {
       
    }
}

//MARK: keyboard hide
extension UIViewController {

    private struct KeyboardHelper {
        static var keyboardDismissGesture: UIGestureRecognizer?
    }

    func addKeyboardDismissGesture() {
        guard KeyboardHelper.keyboardDismissGesture == nil else { return }
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        KeyboardHelper.keyboardDismissGesture = tap
    }

    func removeKeyboardDismissGesture() {
        guard let gesture = KeyboardHelper.keyboardDismissGesture else { return }
        view.removeGestureRecognizer(gesture)
        KeyboardHelper.keyboardDismissGesture = nil
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

}
