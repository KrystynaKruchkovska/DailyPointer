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
}


class Router: AnyRouter {
    
    var entryPoint: EntryPoint?
    
    static func start() -> AnyRouter {
        let router = Router()
        
        //Asign VIP
        var view: AnyView = RootViewController()
        var presenter: AnyPresenter = RootControllerPresenter()
        var interactor: AnyInteractor = MainInteractor()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.interactor = interactor
        presenter.router = router
        
        router.entryPoint = view as? EntryPoint
        
        return router
    }
        
    
}
