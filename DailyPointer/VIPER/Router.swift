//
//  File.swift
//  DailyPointer
//
//  Created by Paweł on 07/07/2022.
//

import Foundation
import UIKit

typealias EntryPoint = AnyView & UIViewController

protocol AnyRouter {
    var entryPoint: EntryPoint? { get set }
    static func start() -> AnyRouter
    func showCreateNewAccountVC()
}


class Router: AnyRouter {
    
    var entryPoint: EntryPoint?
    var currentView: AnyView?
    
    static func start() -> AnyRouter {
        let router = Router()
        
        //Asign VIP
//        var view: AnyView = MapViewController(locationManager: LacationManager())
        var view: AnyView = LoginViewController()
        var presenter: AnyPresenter = LoginPresenter()
        var interactor: AnyInteractor = MapInteractor()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.interactor = interactor
        presenter.view = view
        
        router.entryPoint = view as? EntryPoint
        router.currentView = view
        
        return router
    }
    
    func showCreateNewAccountVC() {
        var createAccountView: AnyView = CreateNewAccount()
        createAccountView.presenter = entryPoint?.presenter
        
        if let view = currentView as? UIViewController {
            view.navigationController?.pushViewController(createAccountView as! UIViewController, animated: true)
        }
    }
        
    
}
