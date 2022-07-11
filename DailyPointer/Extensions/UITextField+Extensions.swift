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


