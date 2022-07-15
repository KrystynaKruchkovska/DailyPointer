//
//  ForgotPasswordVC.swift
//  DailyPointer
//
//  Created by Paweł on 15/07/2022.
//

import UIKit


protocol ForgotPasswordViewProtocol {
    var presenter: ForgotPasswordPresenterProtocol? { get set }
}

class ForgotPasswordVC: UIViewController, ForgotPasswordViewProtocol {
    var presenter: ForgotPasswordPresenterProtocol?
    
    private var mainView: ForgotPasswordView? {
        view as? ForgotPasswordView
    }
    
    override func loadView() {
        super.loadView()
        self.view = ForgotPasswordView()
    }
    
    override func viewDidLayoutSubviews() {
        mainView?.resetPasswordBtn.addTarget(self, action: #selector(pressedResetPassword(sender:)), for: .touchUpInside)
        mainView?.emailTextField.delegate = self
    }
    
    @objc func pressedResetPassword(sender: UIButton) {
        presenter?.resetPasswordPressed(email: mainView?.emailTextField.text ?? "")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

