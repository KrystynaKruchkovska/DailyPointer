//
//  SignInInteractor.swift
//  DailyPointer
//
//  Created by Paweł on 11/07/2022.
//

import Foundation

protocol SignInInteractorProtocol {
    var presenter: SignInPresenterProtocol? { get set }
    func signIn(authType: AuthTypes, credentials: AnyCredetials, handler: @escaping(Result<FireBaseUser, Error>)->())
}

class SignInInteractor: SignInInteractorProtocol {
    weak var presenter: SignInPresenterProtocol?
    private var authService: AuthServiceProtocol = FirebaseAuthService.shared
    

    func signIn(authType: AuthTypes, credentials: AnyCredetials, handler: @escaping(Result<FireBaseUser, Error>)->()) {
        authService.singIn(with: authType, credentials: credentials) { result in
            switch result {
            case .success(let user):
                handler(.success(user))
            case .failure(let error):
                handler(.failure(error))
            }
        }
    }
    
    func checkIsUserVerified(user: FIRUser) -> Bool {
        return user.isEmailVerified
    }
}

