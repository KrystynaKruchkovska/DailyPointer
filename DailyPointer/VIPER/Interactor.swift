//
//  Interactor.swift
//  DailyPointer
//
//  Created by Paweł on 07/07/2022.
//

import Foundation


protocol MapInteractorProtocol {
    var presenter: MapPresenter? { get set }
}

class MapInteractor: MapInteractorProtocol {
    weak var presenter: MapPresenter?
    
    func getAllPosts() -> [Post] {
        return [Post(title: "SomeTitle", description: "some description", location: Location(lat: 34, long: -135))]
    }
}
