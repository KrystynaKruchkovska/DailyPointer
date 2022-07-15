//
//  CreateNewAccountPresenter.swift
//  DailyPointer
//
//  Created by Paweł on 12/07/2022.
//

import Foundation

protocol CreateNewAccountPresenterProtocol: AnyObject {
    var view: CreateNewAccountViewProtocol? { get set }
    var router: LogInRouterProtocol? { get set }
    var interactor: CreateNewAccountInteractorProtocol? { get set }
    func createNewUser(_ user: UserBaseData)
    func showEmailSendPopUp()
}


class CreateNewAccountPresenter: CreateNewAccountPresenterProtocol {
    var interactor: CreateNewAccountInteractorProtocol?
    var view: CreateNewAccountViewProtocol?
    var router: LogInRouterProtocol?
   
    
    func createNewUser(_ user: UserBaseData) {
        interactor?.createNewUser(user, handler: { [weak self] result in
            
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self?.router?.showPoUpView(with: "Check Your email")
//                    self?.router?.popToRootViewController()
                }
            case .failure(let error):
                self?.router?.showAlertVC(title: "Error", messsage: error.localizedDescription, actions: [.signIn])
            }
        })
    }
    func showEmailSendPopUp() {
        print("[MAIL SEND]")
    }
}
