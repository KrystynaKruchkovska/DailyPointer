//
//  View.swift
//  DailyPointer
//
//  Created by Paweł on 07/07/2022.
//

import Foundation
import UIKit

protocol AnyView {
    var presenter: AnyPresenter? { get set }
}

class RootViewController: UIViewController, AnyView {
    var presenter: AnyPresenter?
    
    override func viewDidLoad() {
        view.backgroundColor = .orange
    }
    
}
