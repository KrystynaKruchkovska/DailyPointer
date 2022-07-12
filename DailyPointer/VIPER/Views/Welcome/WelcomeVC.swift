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
    func update(with user: FireBaseUser)
    func update(with error: Error)
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
    }
    
    override func viewDidLayoutSubviews() {
        welcomeView.createNewAccountBtn.addTarget(self, action: #selector(pressedCreateNewAccount(sender:)), for: .touchUpInside)
        welcomeView.logInBtn.addTarget(self, action: #selector(pressedlogInBtn(sender:)), for: .touchUpInside)
    }
    
    @objc func pressedCreateNewAccount(sender: UIButton) {
        presenter?.router?.showCreateNewAccountVC()
    }
    
    @objc func pressedlogInBtn(sender: UIButton) {
        presenter?.signIn(authType: .email, credentials: EmailCredentials(email: welcomeView.emailTextField.text ?? "", password: welcomeView.passwordTextField.text ?? ""))
    }
    
    func update(with user: FireBaseUser) {
     
        self.presenter?.router?.showMapViewController(user: user)
        print("[USER] SIGNED IN")
    }
    func update(with error: Error) {
        self.presenter?.router?.showAlertVC(title: "Oops", messsage: error.localizedDescription)
        print("[ERROR] SIGNED IN \(error)")
    }
}

