//
//  MapPresenter.swift
//  DailyPointer
//
//  Created by Paweł on 12/07/2022.
//

import Foundation

protocol MapPresenterProtocol: AnyObject {
    var view: MapViewProtocol? { get set }
    var router: MapRouterProtocol? { get set }
    var interactor: MapInteractorProtocol? { get set }
    func signOut()
}

class MapPresenter: MapPresenterProtocol {
    var interactor: MapInteractorProtocol?
    var view: MapViewProtocol?
    var router: MapRouterProtocol?

    func signOut() {
        interactor?.signOut(handler: { [weak self] error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.router?.showAlertVC(title: "Opps", messsage: error.localizedDescription, actions: nil)
                } else {
                    self?.router?.showLoginViewController()
                }
            }
        })
        
    }
}
