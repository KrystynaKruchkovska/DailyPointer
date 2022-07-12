//
//  MapPresenter.swift
//  DailyPointer
//
//  Created by Paweł on 12/07/2022.
//

import Foundation

protocol MapPresenterProtocol {
    var view: MapViewProtocol? { get set }
    var router: LogInRouter? { get set }
    var interactor: MapInteractor? { get set }
}

class MapPresenter: MapPresenterProtocol {
    var interactor: MapInteractor?
    var view: MapViewProtocol?
    var router: LogInRouter?
}
