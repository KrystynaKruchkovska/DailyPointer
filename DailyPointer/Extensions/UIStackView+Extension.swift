//
//  UIStackView+Extension.swift
//  DailyPointer
//
//  Created by Paweł on 11/07/2022.
//

import Foundation
import UIKit

extension UIStackView {
    convenience init(
         arrangedSubviews: [UIView],
         axis: NSLayoutConstraint.Axis,
         spacing: CGFloat = 0.0,
         alignment: UIStackView.Alignment = .fill,
         distribution: UIStackView.Distribution = .fill) {
         self.init(arrangedSubviews: arrangedSubviews)
         self.axis = axis
         self.spacing = spacing
         self.alignment = alignment
         self.distribution = distribution
     }
}
