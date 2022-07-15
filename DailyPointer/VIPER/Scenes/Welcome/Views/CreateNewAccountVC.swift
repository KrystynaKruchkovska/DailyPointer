//
//  CreateNewAccount.swift
//  DailyPointer
//
//  Created by Paweł on 07/07/2022.
//

import Foundation
import UIKit

protocol CreateNewAccountViewProtocol {
    var presenter: CreateNewAccountPresenterProtocol? { get set }
}

class CreateNewAccountVC: UIViewController, CreateNewAccountViewProtocol {
    var presenter: CreateNewAccountPresenterProtocol?
    
    private var newAccountView: NewAccountView {
        return view as! NewAccountView
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = NewAccountView()

        newAccountView.nextBtn.addTarget(self, action: #selector(nextBtnClicked(_:)), for: .touchUpInside)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        [newAccountView.nickNameTextField,
         newAccountView.emailTextField,
         newAccountView.passwordTextField].forEach { textField in
            textField.delegate = self
        }
    }
    
    @objc func nextBtnClicked(_ button: UIButton) {

        presenter?.createNewUser(UserBaseData(nickname: newAccountView.nickNameTextField.text ?? "", email: newAccountView.emailTextField.text ?? "", password: newAccountView.passwordTextField.text ?? ""))
    }
}
