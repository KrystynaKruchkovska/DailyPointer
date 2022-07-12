//
//  Presenter.swift
//  DailyPointer
//
//  Created by Paweł on 07/07/2022.
//

import Foundation

//protocol AnyPresenter: AnyObject {
//    var view: AnyView? { get set }
//    var router: AnyRouter? { get set }
//    var interactor: AnyInteractor? { get set }
//}

protocol SignInPresenterProtocol: AnyObject {
    var view: SignInViewProtocol? { get set }
    var router: AnyRouter? { get set }
    var interactor: SignInInteractorProtocol? { get set }
    func signIn(authType: AuthTypes, credentials: AnyCredetials)
}

class SigninPresenter: SignInPresenterProtocol {
    var router: AnyRouter?
    var view: SignInViewProtocol?
    var interactor: SignInInteractorProtocol?
    
    init(view: SignInViewProtocol? = nil, interactor: SignInInteractorProtocol = SignInInteractor(), router: AnyRouter? = nil) {
        self.interactor = interactor
        self.view = view
        self.router = router
    }
 
    func signIn(authType: AuthTypes, credentials: AnyCredetials) {
        
        interactor?.signIn(authType: authType, credentials: credentials, handler: { [weak self] result in
            switch result {
            case .success(let user):
                if user.isEmailVerified {
                    self?.router?.showMapViewController(user: user)
                }
                else {
                    self?.router?.showAlertVC(title: "mail is not verified", messsage: "Please verify your mail" )
                }
                
            case .failure(let error):
                self?.router?.showAlertVC(title: "Opps error occurred", messsage: error.localizedDescription)
            }
        })
    }
}

