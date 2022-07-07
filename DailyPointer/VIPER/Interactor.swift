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

class MainInteractor: AnyInteractor {
    var presenter: AnyPresenter?
    
    
}
