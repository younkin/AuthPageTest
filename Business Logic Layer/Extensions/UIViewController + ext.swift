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
    
    func showToast(message: String) {
        let toastView = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 50))
        toastView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastView.layer.cornerRadius = 10

        let toastLabel = UILabel(frame: CGRect(x: 10, y: 10, width: 240, height: 30))
        toastLabel.text = message
        toastLabel.textColor = AppColors.lightGray
        toastLabel.textAlignment = .left
        toastView.addSubview(toastLabel)

        let tryAgainButton = UIButton(type: .system)
        tryAgainButton.setTitle("Try Again", for: .normal)
        tryAgainButton.setTitleColor(AppColors.orange, for: .normal)
        tryAgainButton.addTarget(self, action: #selector(tryAgainButtonTapped), for: .touchUpInside)
        toastView.addSubview(tryAgainButton)

        self.view.addSubview(toastView)
        toastView.alpha = 0.0
        
        toastView.snp.makeConstraints {
            $0.leading.equalTo(self.view.snp.leading).offset(20)
            $0.trailing.equalTo(self.view.snp.trailing).offset(-20)
            $0.bottom.equalTo(self.view.snp.bottom).offset(-20)
            $0.height.equalTo(50)
        }

        toastLabel.snp.makeConstraints {
            $0.leading.equalTo(toastView.snp.leading).offset(10)
            $0.trailing.equalTo(toastView.snp.trailing).offset(-10)
            $0.top.equalTo(toastView.snp.top).offset(10)
            $0.bottom.equalTo(toastView.snp.bottom).offset(-10)
        }

        tryAgainButton.snp.makeConstraints {
            $0.trailing.equalTo(toastView.snp.trailing).offset(-10)
            $0.centerY.equalTo(toastView.snp.centerY)
            $0.width.equalTo(100)
            $0.height.equalTo(50)
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
        //
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
