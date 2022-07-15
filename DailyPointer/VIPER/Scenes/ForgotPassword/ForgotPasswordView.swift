//
//  ForgotPasswordView.swift
//  DailyPointer
//
//  Created by Paweł on 15/07/2022.
//

import UIKit

class ForgotPasswordView: UIView {
        
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addSubview(stackView)
        stackView.anchor(canterXAnchor: self.centerXAnchor, canterYAnchor:self.centerYAnchor, left: self.leftAnchor, right: self.rightAnchor, topConstant: 0, bottomConstant: 0, leftConstant: 20, rightConstant: 20)
        self.backgroundColor = .yellow
    }
    
    var descriptionLabel: UILabel = {
        var label = UILabel(text: "We'll send you email were you can change your password", textAlignment: .center, font: UIFont.systemFont(ofSize: 16))
        return label
    }()
    
    var emailTextField: UITextField = {
        var textField = UITextField(placeholder: "email", textColor: .blue)
        return textField
    }()
        
    var resetPasswordBtn: UIButton = {
        var button = UIButton(title: "Send email", backgroundColor: .systemBlue, titleColor: .white)
        return button
    }()
    
    fileprivate lazy var stackView: UIStackView = {
        var vStackView = UIStackView(arrangedSubviews: [descriptionLabel, emailTextField, resetPasswordBtn], axis: .vertical, spacing: 16, alignment: .fill, distribution: .equalCentering)
        return vStackView
    }()
    
}
