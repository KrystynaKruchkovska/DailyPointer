//
//  File.swift
//  DailyPointer
//
//  Created by Paweł on 07/07/2022.
//

import Foundation
import UIKit

typealias EntryPoint = SignInViewProtocol & UIViewController

protocol BaseRouter {
    var rootViewController: UIViewController? { get set }
    func showAlertVC(title: String, messsage: String, actions: [AlertActionTypes]?)
    func showPoUpView(with text: String)
}

extension BaseRouter {
    func showAlertVC(title: String, messsage: String, actions: [AlertActionTypes]?) {
        let alert = UIAlertController(title: title, message: messsage, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        if let vc = rootViewController {
            vc.present(alert, animated: true)
        }
    }
    
    func showPoUpView(with text: String) {
        if let vc  = rootViewController?.navigationController?.viewControllers.last {
            DispatchQueue.main.async {
                let view = Popup(titleText: text)
                view.frame = vc.view!.bounds
                view.layer.zPosition = 1
                vc.view.addSubview(view)
            }
        }
    }
    
}

protocol LogInRouterProtocol: BaseRouter {
    var entryPoint: EntryPoint? { get set }
    static func start() -> LogInRouterProtocol
    func showCreateNewAccountVC()
    func showForgotPasswordVC()
    func showMapViewController(user: FIRUser)
    func popToRootViewController()
}


enum AlertActionTypes: String {
    case signIn = "Sign In"
    case openEmail = "Open Email"
}


class LogInRouter: LogInRouterProtocol {
    var entryPoint: EntryPoint?
    var rootViewController: UIViewController?
    
    static func start() -> LogInRouterProtocol {
        let router = LogInRouter()
        
        //Asign VIP
        var view: SignInViewProtocol = WelcomeViewController()
        let presenter: SignInPresenterProtocol = SigninPresenter()
        var interactor: SignInInteractorProtocol = SignInInteractor()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.interactor = interactor
        presenter.view = view
        
        router.entryPoint = view as? EntryPoint
        router.rootViewController = view as? UIViewController
        
        return router
    }
    
    func showCreateNewAccountVC() {
        var createNewAccountVC: CreateNewAccountViewProtocol = CreateNewAccountVC()
        var interactor: CreateNewAccountInteractorProtocol = CreateNewAccountInteractor()
        let presenter: CreateNewAccountPresenterProtocol = CreateNewAccountPresenter()
        
        createNewAccountVC.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.view = createNewAccountVC
        presenter.interactor = interactor
        presenter.router = self
        
        rootViewController?.navigationController?.pushViewController(createNewAccountVC as! UIViewController, animated: true)
    }
    
    func showMapViewController(user: FIRUser) {
        var createMapView: MapViewProtocol = MapViewController(locationManager: LacationManager(), user: user)
        let presenter: MapPresenterProtocol = MapPresenter()
        var interactor: MapInteractorProtocol = MapInteractor()
        createMapView.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.view = createMapView
        presenter.interactor = interactor
        
        let router = MapRouter()
        router.rootViewController = rootViewController
        presenter.router = router
        
        
        rootViewController?.navigationController?.pushViewController(createMapView as! UIViewController, animated: true)
    }
    
    func popToRootViewController() {
        rootViewController?.navigationController?.popToRootViewController(animated: true)
    }
    
    func showAlertVC(title: String, messsage: String, actions: [AlertActionTypes]?) {
        let alert = UIAlertController(title: title, message: messsage, preferredStyle: .actionSheet)
        
        if let actions = actions {
            actions.forEach { action in
                switch action {
                case .signIn:
                    alert.addAction(UIAlertAction(title: action.rawValue, style: .default, handler: navigateToSignIn))
                case .openEmail:
                    alert.addAction(UIAlertAction(title: action.rawValue, style: .default, handler: verifyEmail))
                }
            }
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        if let vc = rootViewController {
            vc.present(alert, animated: true)
        }
    }
    
    func navigateToSignIn(action: UIAlertAction) {
        if let _ = rootViewController as? SignInViewProtocol {
            popToRootViewController()
        }
    }
    
    func verifyEmail(action: UIAlertAction) {
        let mailURL = URL(string: "message://noreply@dailypointer-2954e.firebaseapp.com")!
        if UIApplication.shared.canOpenURL(mailURL) {
            UIApplication.shared.open(mailURL)
        }
    }
        
    func showForgotPasswordVC() {
        var forgotPasswordVC: ForgotPasswordViewProtocol = ForgotPasswordVC()
        var interactor: ForgotPasswordInteractorProtocol = ForgotPasswordInteractor()
        var presenter: ForgotPasswordPresenterProtocol = ForgotPasswordPresenter()
        var router:ForgotPasswordRouterProtocol = ForgotPasswordRouter()
        router.rootViewController = rootViewController
        
        forgotPasswordVC.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.view = forgotPasswordVC
        presenter.interactor = interactor
        presenter.router = router
        
        rootViewController?.navigationController?.pushViewController(forgotPasswordVC as! UIViewController, animated: true)
    }
    
}
