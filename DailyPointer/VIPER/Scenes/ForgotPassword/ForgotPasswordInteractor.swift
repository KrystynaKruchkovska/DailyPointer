//
//  ForgotPasswordInteractor.swift
//  DailyPointer
//
//  Created by Paweł on 15/07/2022.
//

import Foundation

protocol ForgotPasswordInteractorProtocol {
    var presenter: ForgotPasswordPresenterProtocol? { get set }
    func resetPassword(email:String, handler: @escaping(Error?)->())
}

class ForgotPasswordInteractor: ForgotPasswordInteractorProtocol {
    
    private var authServise: AuthServiceProtocol? = FirebaseAuthService.shared
    var presenter: ForgotPasswordPresenterProtocol?
    
    func resetPassword(email:String, handler: @escaping(Error?)->()) {
        authServise?.resetPassword(email: email) { error in
            handler(error)
        }
    }
    
}
