//
//  Login.swift
//  DailyPointer
//
//  Created by Paweł on 07/07/2022.
//

import Foundation
import UIKit
import RxSwift

protocol SignInViewProtocol {
    var presenter: SignInPresenterProtocol? { get set }
}

class WelcomeViewController: UIViewController, SignInViewProtocol {
    var presenter: SignInPresenterProtocol?
    
    private var welcomeView: WelcomeView {
        return view as! WelcomeView
    }
        
    override func loadView() {
        let welcomeView = WelcomeView()
        view = welcomeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        [welcomeView.emailTextField,
         welcomeView.passwordTextField].forEach { textField in
            textField.delegate = self
        }

    }
    
    override func viewDidLayoutSubviews() {
        welcomeView.createNewAccountBtn.addTarget(self, action: #selector(pressedCreateNewAccount(sender:)), for: .touchUpInside)
        welcomeView.forgotPassword.addTarget(self, action: #selector(pressedForgotPassword(sender:)), for: .touchUpInside)
        welcomeView.logInBtn.addTarget(self, action: #selector(pressedlogInBtn(sender:)), for: .touchUpInside)
    }
    
    @objc func pressedCreateNewAccount(sender: UIButton) {
        presenter?.showCreateNewAccountVC()
    }
    
    @objc func pressedForgotPassword(sender: UIButton) {
        presenter?.showForgotPasswordVC()
    }
    
    @objc func pressedlogInBtn(sender: UIButton) {
        presenter?.signIn(authType: .email, credentials: EmailCredentials(email: welcomeView.emailTextField.text ?? "", password: welcomeView.passwordTextField.text ?? ""))
    }
}

