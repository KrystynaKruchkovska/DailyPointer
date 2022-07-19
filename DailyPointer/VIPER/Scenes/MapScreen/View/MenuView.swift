//
//  MenuView.swift
//  DailyPointer
//
//  Created by Paweł on 18/07/2022.
//

import UIKit

class MenuView: UIView {
    
    override init(frame:CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .systemCyan
    }
    
}
