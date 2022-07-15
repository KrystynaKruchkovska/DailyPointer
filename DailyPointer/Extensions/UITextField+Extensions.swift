//
//  UITextField+Extensions.swift
//  DailyPointer
//
//  Created by Paweł on 11/07/2022.
//

import UIKit

extension UITextField {
    
    convenience init(placeholder: String, font: UIFont = UIFont.systemFont(ofSize: 13), textColor: UIColor) {
        self.init(frame: .zero)
        self.textColor = textColor
        self.textAlignment = .left
        self.placeholder = placeholder
        self.borderStyle = .roundedRect
        self.autocorrectionType = .no
    
        self.clearButtonMode = .whileEditing
    }
}

extension UITextField {
    fileprivate func setPasswordToggleImage(_ button: UIButton) {
        if (isSecureTextEntry) {
            button.setImage(UIImage(systemName: "eye"), for: .normal)
        } else {
            button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        }
    }

    func enablePasswordToggle() {
        
        var plain = UIButton.Configuration.plain()

        plain.buttonSize = .mini
        plain.imagePlacement = .trailing
        plain.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 5)
        
        let button = UIButton(configuration: plain)
        setPasswordToggleImage(button)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .systemGray3
        button.addTarget(self, action: #selector(self.togglePasswordView), for: .touchUpInside)
        
        self.rightView = button
        self.rightViewMode = .always
    }
    
    @objc func togglePasswordView(_ sender: Any) {
        self.isSecureTextEntry = !self.isSecureTextEntry
        setPasswordToggleImage(sender as! UIButton)
    }
}
