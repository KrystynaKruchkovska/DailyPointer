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
    func showAlertVC(title: String, messsage: String)
}


class Router: AnyRouter {
    
    var entryPoint: EntryPoint?
    var currentView: AnyView?
    
    static func start() -> AnyRouter {
        let router = Router()
        
        //Asign VIP
        //        var view: AnyView = MapViewController(locationManager: LacationManager())
        var view: AnyView = WelcomeViewController()
        let presenter: AnyPresenter = SigninPresenter()
        var interactor: AnyInteractor = SignInInteractor()
        
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
        var createAccountView: AnyView = CreateNewAccountVC()
        createAccountView.presenter = entryPoint?.presenter
        
        if let view = currentView as? UIViewController {
            view.navigationController?.pushViewController(createAccountView as! UIViewController, animated: true)
        }
    }
    
    func showAlertVC(title: String, messsage: String) {
        let alert = UIAlertController(title: title, message: messsage, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Sign In", style: .default, handler: doSomething))
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        if let view = currentView as? UIViewController {
            view.present(alert, animated: true)
        }
        
        
    }
    func doSomething(action: UIAlertAction) {
        print("HERE:")
    }
    
    
    
}
