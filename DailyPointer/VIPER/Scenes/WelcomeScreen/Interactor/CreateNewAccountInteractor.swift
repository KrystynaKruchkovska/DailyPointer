//
//  CreateNewAccountInteractor.swift
//  DailyPointer
//
//  Created by Paweł on 11/07/2022.
//

import Foundation

protocol CreateNewAccountInteractorProtocol {
    var presenter: CreateNewAccountPresenterProtocol? { get set }
    func createNewUser(_ user: UserBaseData, handler: @escaping(Result<FIRUser, Error>) -> ())
}

class CreateNewAccountInteractor: CreateNewAccountInteractorProtocol {
    var presenter: CreateNewAccountPresenterProtocol?
    private var authService: AuthServiceProtocol = FirebaseAuthService.shared
    
    func createNewUser(_ user: UserBaseData, handler: @escaping(Result<FIRUser, Error>) -> ()) {
        authService.createNewAccount(user: user) { [weak self] (result) in
            switch result {
            case .success(let firebaseUser):
                self?.authService.sendVerificationEmail(user: firebaseUser) { error in
                    if let error = error {
                        handler(.failure(error))
                    } else {
                        self?.presenter?.showEmailSendPopUp()
                    }
                }
                handler(.success(firebaseUser))
            case .failure(let error):
                handler(.failure(error))
            }
        }
    }
    
    func sendVereficationEmail(user: FIRUser, handler: @escaping (Error?) -> ()) {
        authService.sendVerificationEmail(user: user) { error in
            handler(error)
        }
    }
    
}


