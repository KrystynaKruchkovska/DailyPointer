//
//  File.swift
//  DailyPointer
//
//  Created by Paweł on 15/07/2022.
//

import Foundation

protocol ForgotPasswordPresenterProtocol {
    var view: ForgotPasswordViewProtocol? { get set }
    var interactor: ForgotPasswordInteractorProtocol? { get set }
    var router: ForgotPasswordRouterProtocol? { get set }
    func resetPasswordPressed(email: String)
}

class ForgotPasswordPresenter: ForgotPasswordPresenterProtocol {
    var view: ForgotPasswordViewProtocol?
    var interactor: ForgotPasswordInteractorProtocol?
    var router: ForgotPasswordRouterProtocol?
    
    func resetPasswordPressed(email: String) {
        interactor?.resetPassword(email: email) { [weak self] error in
            if let error = error {
                self?.router?.showPoUpView(with: "Opps, \(error.localizedDescription)")
            } else {
                self?.router?.showPoUpView(with: "Successfully send mail.")
            }
        }
    }
}
