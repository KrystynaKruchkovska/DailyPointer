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
    
//    private var interactor: CreateNewAccountInteractorProtocol?
    private var newAccountView:NewAccountView {
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
        presenter?.createNewUser(UserBaseData(nickname: newAccountView.nickNameTextField.text ?? "", email: newAccountView.emailTextField.text ?? "", password: newAccountView.passwordTextField.text ?? ""))
    }
}

extension CreateNewAccountVC: UITextFieldDelegate {
    
    
}
//
//
//                                 , handler: { [weak self] result in
//
//                                         DispatchQueue.main.async {
//                                             switch result {
//                                             case .success:
//                                                 print("success creating USER")
//                                             case .failure(let error):
//                                                 self?.presenter?.router?.showAlertVC(title: "Opps error creating user", messsage: error.localizedDescription)
//                                                 print("[ERROR]:\(error)")
//                                             }
//                                         }
//                                     })
