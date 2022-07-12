//
//  File.swift
//  DailyPointer
//
//  Created by Paweł on 07/07/2022.
//

import Foundation
import UIKit

typealias EntryPoint = SignInViewProtocol & UIViewController

protocol AnyRouter {
    var entryPoint: EntryPoint? { get set }
    static func start() -> AnyRouter
    func showCreateNewAccountVC()
    func showAlertVC(title: String, messsage: String)
    func showMapViewController(user: FIRUser)
}


class LogInRouter: AnyRouter {
    
    var entryPoint: EntryPoint?
   
    static func start() -> AnyRouter {
        let router = LogInRouter()
        
        //Asign VIP
        //        var view: AnyView = MapViewController(locationManager: LacationManager())
        var view: SignInViewProtocol = WelcomeViewController()
        let presenter: SignInPresenterProtocol = SigninPresenter()
        var interactor: SignInInteractorProtocol = SignInInteractor()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.interactor = interactor
        presenter.view = view
        
        router.entryPoint = view as? EntryPoint
        
        return router
    }
    
    func showCreateNewAccountVC() {
        var createAccountView:CreateNewAccountViewProtocol = CreateNewAccountVC()
        createAccountView.presenter = CreateNewAccountPresenter()
        
        if let vc = entryPoint {
            vc.navigationController?.pushViewController(createAccountView as! UIViewController, animated: true)
        }
    }
    
    func showAlertVC(title: String, messsage: String) {
        let alert = UIAlertController(title: title, message: messsage, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Sign In", style: .default, handler: doSomething))
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        if let vc = entryPoint {
            vc.present(alert, animated: true)
        }
        
        
    }
    func doSomething(action: UIAlertAction) {
        print("HERE:")
    }
    
    
    func showMapViewController(user: FIRUser) {
        var createMapView: MapViewProtocol = MapViewController(locationManager: LacationManager(), user: user)
        createMapView.presenter = MapPresenter()
        
        if let vc = entryPoint {
            vc.navigationController?.pushViewController(createMapView as! UIViewController, animated: true)
        }
    }

}
