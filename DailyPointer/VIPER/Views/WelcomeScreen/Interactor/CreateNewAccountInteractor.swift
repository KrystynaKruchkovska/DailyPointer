//
//  CreateNewAccountInteractor.swift
//  DailyPointer
//
//  Created by Paweł on 11/07/2022.
//

import Foundation

class CreateNewAccountInteractor: AnyInteractor {
    weak var presenter: AnyPresenter?
    var authService: AnyFirebaseAuthService
    
    init() {
        self.authService = FirebaseAuthService()
    }

    func createNewUser(_ user: UserBaseData, handler: @escaping(Result<AnyFirebaseUser, Error>) -> ()) {
        authService.createNewAccount(user: user) { (result) in
            switch result {
            case .success(let firebaseUser):
                handler(.success(firebaseUser))
            case .failure(let error):
                handler(.failure(error))
            }
        }
    }
}


