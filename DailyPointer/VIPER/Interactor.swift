//
//  Interactor.swift
//  DailyPointer
//
//  Created by Paweł on 07/07/2022.
//

import Foundation


protocol AnyInteractor {
    var presenter: AnyPresenter? { get set }
}

class MapInteractor: AnyInteractor {
    var presenter: AnyPresenter?
    
    func getAllPosts() -> [Post] {
        return [Post(title: "SomeTitle", description: "some description", location: Location(lat: 34, long: -135))]
    }
}
