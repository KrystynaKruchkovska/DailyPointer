//
//  Login.swift
//  DailyPointer
//
//  Created by Paweł on 07/07/2022.
//

import Foundation
import UIKit

class LoginViewController: UIViewController, AnyView {
    var presenter: AnyPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
    }
    
    override func viewDidLayoutSubviews() {
        view.addSubview(loginVStackView)
        loginVStackView.addArrangedSubview(mainLabel)
        loginVStackView.addArrangedSubview(createNewAccountBtn)
        loginVStackView.addArrangedSubview(logInBtn)
        setUpConstraints()
    }
    
    
    var mainLabel: UILabel = {
        var label = UILabel()
        label.text = "Daily Pointer"
        label.textAlignment = .center
        label.font = UIFont(name:"AvenirNext-Bold", size: 30)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.01
        
        return label
    }()
    
    lazy var createNewAccountBtn: UIButton = {
        var button = UIButton()
        button.layer.cornerRadius = 5.0
        button.backgroundColor = .systemBlue
        button.setTitle("Create New Account", for: .normal)
        button.addTarget(self, action: #selector(pressedCreateNewAccount(sender:)), for: .touchUpInside)
        return button
    }()

    @objc func pressedCreateNewAccount(sender: UIButton) {
        print("Create new account")
        presenter?.router?.showCreateNewAccountVC()
    }
    
    lazy var logInBtn: UIButton = {
        var button = UIButton()
        button.layer.cornerRadius = 5.0
        button.titleLabel?.textColor = .systemBlue
        button.setTitle("Log in", for: .normal)
        button.addTarget(self, action: #selector(pressedlogInBtn(sender:)), for: .touchUpInside)
        return button
    }()

    @objc func pressedlogInBtn(sender: UIButton) {
        print("Log in")
    }
    
    var loginVStackView: UIStackView = {
        var vStackView = UIStackView()
        vStackView.axis = .vertical
        vStackView.distribution = .equalSpacing
        vStackView.spacing = 16
        vStackView.translatesAutoresizingMaskIntoConstraints = false

        return vStackView
        
    }()
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            loginVStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginVStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
    }
    
}
