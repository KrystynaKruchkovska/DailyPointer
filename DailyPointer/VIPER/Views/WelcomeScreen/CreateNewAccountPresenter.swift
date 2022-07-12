//
//  CreateNewAccountPresenter.swift
//  DailyPointer
//
//  Created by Paweł on 12/07/2022.
//

import Foundation

protocol CreateNewAccountPresenterProtocol: AnyObject {
    var view: CreateNewAccountViewProtocol? { get set }
    var router: AnyRouter? { get set }
    var interactor: CreateNewAccountInteractorProtocol? { get set }
    func createNewUser(_ user: UserBaseData)
}


class CreateNewAccountPresenter: CreateNewAccountPresenterProtocol {
    var view: CreateNewAccountViewProtocol?
    
    var router: AnyRouter?
    
    var interactor: CreateNewAccountInteractorProtocol?
    
    func createNewUser(_ user: UserBaseData) {
        interactor?.createNewUser(user, handler: { [weak self] result in
            
            switch result {
            case .success:
                print("[NEW USER CREATED]")
            case .failure(let error):
                print("[NEW USER FAILD while CREATING] \(error)")

            }
            if let rootVC = self?.router?.entryPoint {
                rootVC.navigationController?.popViewController(animated: true)
            }
        })
    }
    
    init() {
        self.interactor = CreateNewAccountInteractor()
    }
    
}
