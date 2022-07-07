//
//  Presenter.swift
//  DailyPointer
//
//  Created by Paweł on 07/07/2022.
//

import Foundation

protocol AnyPresenter {
    var view: AnyView? { get set }
    var router: AnyRouter? { get set }
    var interactor: AnyInteractor? { get set }
}

class RootControllerPresenter: AnyPresenter {
    var router: AnyRouter?
    var view: AnyView?
    var interactor: AnyInteractor?
}
