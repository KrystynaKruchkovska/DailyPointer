//
//  UILabel + Extension.swift
//  DailyPointer
//
//  Created by Paweł on 11/07/2022.
//

import UIKit

extension UILabel {
    
    convenience init(text: String,textAlignment: NSTextAlignment, font: UIFont? = UIFont(name:"AvenirNext-Bold", size: 30)) {
        self.init()
        self.text = text
        self.textAlignment = textAlignment
        self.font = font
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.01
    }
}
