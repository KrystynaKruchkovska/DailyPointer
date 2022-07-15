//
//  MapRouter.swift
//  DailyPointer
//
//  Created by Paweł on 13/07/2022.
//

import UIKit

protocol MapRouterProtocol: BaseRouter {
    func showLoginViewController()
}

class MapRouter: MapRouterProtocol {
    var rootViewController: UIViewController?
    
    func showLoginViewController() {
        rootViewController?.navigationController?.popToRootViewController(animated: true)
    }
}
