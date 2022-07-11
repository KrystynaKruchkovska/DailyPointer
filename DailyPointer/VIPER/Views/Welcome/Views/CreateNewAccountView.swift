//
//  File.swift
//  DailyPointer
//
//  Created by Paweł on 11/07/2022.
//

import UIKit

class NewAccountView: UIView {
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addSubview(vStackView)
        vStackView.anchor(top:self.safeAreaLayoutGuide.topAnchor, left: self.leftAnchor, right: self.rightAnchor, topConstant: 20, bottomConstant: 0, leftConstant: 20, rightConstant: 20)
        [nickNameTextField, emailTextField, passwordTextField, nextBtn].forEach{ view in
            view.anchor(heightConstant: 50)
            vStackView.addArrangedSubview(view)
            
        }

    }
    
    var vStackView: UIStackView = {
        var stackView =  UIStackView(arrangedSubviews: [], axis: .vertical, spacing: 10, alignment: .fill, distribution: .equalCentering)
        return stackView
    }()
    

    var nickNameTextField: UITextField = {
        var textField = UITextField(placeholder: "nickname", textColor: .blue)
        return textField
    }()
    
    var emailTextField: UITextField = {
        var textField = UITextField(placeholder: "email", textColor: .blue)
        return textField
    }()
    
    var passwordTextField: UITextField = {
        var textField = UITextField(placeholder: "password", textColor: .blue)
        return textField
    }()
    
    var nextBtn: UIButton = {
        var button = UIButton(title: "Next", backgroundColor: .systemBlue, titleColor: .white)
        return button
    }()
}

