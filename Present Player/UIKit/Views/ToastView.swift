//
//  ToastView.swift
//  AuthPageTest
//
//  Created by Евгений Юнкин on 07.01.23.
//

import Foundation
import UIKit



final class ToastView: UIView {
    enum Style {
        case normal
        case active(() -> Void)
    }
    
    private lazy var toastLabel: UILabel = {
        let label = UILabel()
        label.text = text
        label.textColor = AppColors.lightGray
        label.textAlignment = .left
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    private lazy var tryAgainButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Try Again", for: .normal)
        button.setTitleColor(AppColors.orange, for: .normal)
        button.addTarget(self, action: #selector(tryAgainButtonTapped), for: .touchUpInside)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.isUserInteractionEnabled = true
        return button
    }()
    
    private let text: String
    private let style: Style
    
    init(text: String, style: Style) {
        self.text = text
        self.style = style
        
        super.init(frame: .zero)
        isUserInteractionEnabled = true
        addSubview(toastLabel)
        
        toastLabel.snp.makeConstraints {
            $0.leading.equalTo(self.snp.leading).offset(10)
            $0.top.equalTo(self.snp.top).offset(10)
            $0.bottom.equalTo(self.snp.bottom).offset(-10)
        }
        
        switch style {
        case .active:
            self.addSubview(tryAgainButton)
            tryAgainButton.snp.makeConstraints {
                $0.trailing.equalTo(self.snp.trailing).offset(-10)
                $0.centerY.equalTo(self.snp.centerY)
                $0.leading.equalTo(toastLabel.snp.trailing).offset(10)
            }
            tryAgainButton.snp.contentCompressionResistanceHorizontalPriority = 750
        case .normal:
            toastLabel.snp.makeConstraints {
                $0.trailing.equalToSuperview().offset(-10)
            }
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func hideToast() {
        UIView.animate(withDuration: 3.0, delay: 2.0, options: [.curveEaseOut, .allowUserInteraction], animations: {
            self.alpha = 0.0
        }, completion: { (isCompleted) in
            self.removeFromSuperview()
        })
    }
    
    @objc func tryAgainButtonTapped() {
        if case let .active(callback) = style {
            callback()
        }
        self.removeFromSuperview()
    }
}
