//
//  CreateNewAccount.swift
//  DailyPointer
//
//  Created by Paweł on 07/07/2022.
//

import Foundation
import UIKit

class CreateNewAccountVC: UIViewController, AnyView {
    var presenter: AnyPresenter?
    
    private var interactor: CreateNewAccountInteractor? {
        return presenter?.interactor as? CreateNewAccountInteractor
    }
    private var newAccountView:NewAccountView {
        return view as! NewAccountView
    }
    
    override func loadView() {
        self.view = NewAccountView()
        newAccountView.nickNameTextField.delegate = self
        newAccountView.nickNameTextField.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        newAccountView.nextBtn.addTarget(self, action: #selector(nextBtnClicked(_:)), for: .touchUpInside)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
    
    
    @objc func textFieldDidEndEditing(_ textField: UITextField) {
        newAccountView.nickNameTextField.resignFirstResponder()
    }
    
    @objc func nextBtnClicked(_ button: UIButton) {
        if let interactor = interactor {
            interactor.createNewUser(UserBaseData(nickname: newAccountView.nickNameTextField.text ?? "", email: newAccountView.emailTextField.text ?? "", password: newAccountView.passwordTextField.text ?? ""), handler: { [weak self] result in
                
                DispatchQueue.main.async {
                    switch result {
                    case .success:
                        print("success creating USER")
                    case .failure(let error):
                        self?.presenter?.router?.showAlertVC(title: "Opps error creating user", messsage: error.localizedDescription)
                        print("[ERROR]:\(error)")
                    }
                }
            })
        }
    }
}

extension CreateNewAccountVC: UITextFieldDelegate {
    
    
}
