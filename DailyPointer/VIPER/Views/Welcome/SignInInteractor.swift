//
//  SignInInteractor.swift
//  DailyPointer
//
//  Created by Paweł on 11/07/2022.
//

import Foundation

class SignInInteractor: AnyInteractor {
    weak var presenter: AnyPresenter?
    var authService: AnyFirebaseAuthService
    
    init() {
        self.authService = FirebaseAuthService()
    }

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
}

