//
//  UIbutton+Extension .swift
//  DailyPointer
//
//  Created by Paweł on 11/07/2022.
//

import UIKit

extension UIButton {
    convenience init(title: String, backgroundColor: UIColor?, titleColor: UIColor?){
        self.init(type: .system)
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = 5
  
    }
}
