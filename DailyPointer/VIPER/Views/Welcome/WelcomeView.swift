//
//  WelcomeView.swift
//  DailyPointer
//
//  Created by Paweł on 11/07/2022.
//

import UIKit

class WelcomeView: UIView {
    init() {
        super.init(frame: .zero)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addSubview(loginVStackView)

        [mainLabel, emailTextField, passwordTextField, logInBtn, createNewAccountBtn].forEach(loginVStackView.addArrangedSubview)
        loginVStackView.anchor(canterXAnchor: self.centerXAnchor, canterYAnchor:self.centerYAnchor, left: self.leftAnchor, right: self.rightAnchor, topConstant: 0, bottomConstant: 0, leftConstant: 20, rightConstant: 20)
        self.backgroundColor = .yellow

    }
    
    var mainLabel: UILabel = {
        var label = UILabel(text: "Daily Pointer", textAlignment: .center)
        return label
    }()
    
    var emailTextField: UITextField = {
        var textField = UITextField(placeholder: "email", textColor: .blue)
        return textField
    }()
    
    var passwordTextField: UITextField = {
        var textField = UITextField(placeholder: "password", textColor: .blue)
        return textField
    }()
    
    var createNewAccountBtn: UIButton = {
        var button = UIButton(title: "Create New Account", backgroundColor: nil, titleColor: .systemBlue)
        return button
    }()
    
    var logInBtn: UIButton = {
        var button = UIButton(title: "Log in", backgroundColor: .systemBlue, titleColor: .white)
        return button
    }()
    
    var loginVStackView: UIStackView = {
        var vStackView = UIStackView(arrangedSubviews: [], axis: .vertical, spacing: 16, alignment: .fill, distribution: .equalCentering)
        return vStackView
    }()
}
