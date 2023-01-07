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
    
    func showToast(message: String, style: ToastView.Style = .normal) {
        let toast = ToastView(text: message, style: style)
        toast.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toast.layer.cornerRadius = 10
        toast.alpha = 0.0
        view.addSubview(toast)

        toast.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.leading.trailing.bottom.equalToSuperview().inset(20)
        }
        UIView.animate(withDuration: 1.0, delay: 0.0, options: [.curveEaseOut, .allowUserInteraction], animations: {
            toast.alpha = 1.0
        }, completion: { (isCompleted) in
            toast.hideToast()
        })
        
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
