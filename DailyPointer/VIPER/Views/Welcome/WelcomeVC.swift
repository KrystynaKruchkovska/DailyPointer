//
//  Login.swift
//  DailyPointer
//
//  Created by Paweł on 07/07/2022.
//

import Foundation
import UIKit
import RxSwift

class WelcomeViewController: UIViewController, AnyView {
    var presenter: AnyPresenter?
    
    private var welcomeView: WelcomeView {
        return view as! WelcomeView
    }
    
    private var interactor: SignInInteractor? {
        return presenter?.interactor as? SignInInteractor
    }
    
    override func loadView() {
        let welcomeView = WelcomeView()
        view = welcomeView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        welcomeView.createNewAccountBtn.addTarget(self, action: #selector(pressedCreateNewAccount(sender:)), for: .touchUpInside)
        welcomeView.logInBtn.addTarget(self, action: #selector(pressedlogInBtn(sender:)), for: .touchUpInside)
    }
    
    @objc func pressedCreateNewAccount(sender: UIButton) {
        print("Create new account")
        presenter?.router?.showCreateNewAccountVC()
    }
    
    @objc func pressedlogInBtn(sender: UIButton) {
        
        interactor?.signIn(authType: .email, credentials: EmailCredentials(email: welcomeView.emailTextField.text ?? "", password: welcomeView.passwordTextField.text ?? ""), handler: { [weak self ] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    print("[USER] SIGNED IN")
                case .failure(let error):
                    print("[ERROR] SIGNED IN \(error)")
                }
            }
        })
        print("Log in")
    }
}

