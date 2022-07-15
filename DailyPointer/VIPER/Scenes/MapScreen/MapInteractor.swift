//
//  Interactor.swift
//  DailyPointer
//
//  Created by Paweł on 07/07/2022.
//

import Foundation


protocol MapInteractorProtocol {
    var presenter: MapPresenterProtocol? { get set }
    func signOut(handler: @escaping (Error?)->())
}

class MapInteractor: MapInteractorProtocol {
    weak var presenter: MapPresenterProtocol?
    private var authService: AuthServiceProtocol = FirebaseAuthService.shared
    
    func signOut(handler: @escaping (Error?)->()) {
        authService.signOut { error in
            handler(error)
        }
    }
}
