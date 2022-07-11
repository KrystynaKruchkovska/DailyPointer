//
//  UIView+Extensions.swift
//  DailyPointer
//
//  Created by Paweł on 11/07/2022.
//

import UIKit

extension UIView {
    func anchor(canterXAnchor: NSLayoutXAxisAnchor? = nil, canterYAnchor: NSLayoutYAxisAnchor? = nil, top: NSLayoutYAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, bottomConstant: CGFloat = 0 , leftConstant: CGFloat = 0, rightConstant: CGFloat = 0, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0 ) {
        translatesAutoresizingMaskIntoConstraints = false
        if let canterXAnchor = canterXAnchor {
            self.centerXAnchor.constraint(equalTo: canterXAnchor).isActive = true

        }
        
        if let canterYAnchor = canterYAnchor {
            self.centerYAnchor.constraint(equalTo: canterYAnchor).isActive = true

        }
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: topConstant).isActive = true
        }

        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant).isActive = true
        }
        
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: -rightConstant).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: leftConstant).isActive = true
        }
        
        if widthConstant != 0 {
            widthAnchor.constraint(equalToConstant: widthConstant).isActive = true
        }
        
        if heightConstant != 0 {
            heightAnchor.constraint(equalToConstant: heightConstant).isActive = true
        }
    }
}
