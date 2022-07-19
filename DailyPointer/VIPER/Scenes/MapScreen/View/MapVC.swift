//
//  View.swift
//  DailyPointer
//
//  Created by Paweł on 07/07/2022.
//

import Combine
import UIKit
import MapKit

protocol MapViewProtocol {
    var presenter: MapPresenterProtocol? { get set }
    var mainView: MapView { get }
}

class MapViewController: UIViewController, MapViewProtocol {
    
    private var isSlideMenuPresented = false
    lazy var slideInMenuPeddings = self.view.frame.width * 0.3
    lazy var menuBarButtonItem: UIBarButtonItem = {
        var button = UIBarButtonItem(image: UIImage(systemName: "sidebar.left")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(sideBarItemTapped))
        return button
    }()
    
    var user: FIRUser
    var presenter: MapPresenterProtocol?    
    lazy var menuView: MenuView = {
        var view = MenuView()
        view.backgroundColor = .yellow
        return view
    }()
    
    lazy var mainView: MapView = {
        var view = MapView()
        return view
    }()
        
    init(user: FIRUser) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuView.pinMenu(to: view, with: slideInMenuPeddings)
        mainView.edge(to: view)
        
        setUpLongPressRecogniser()
        mainView.mapView.delegate = presenter
        presenter?.observeDeviceLocationService()
        self.navigationItem.leftItemsSupplementBackButton = false
        navigationItem.setLeftBarButtonItems([menuBarButtonItem], animated: false)
        mainView.signOutButton.addTarget(self, action: #selector(signOut(_:)), for: .touchDown)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func sideBarItemTapped() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0, options: .curveEaseInOut) { [self] in
            self.mainView.frame.origin.x = self.isSlideMenuPresented ? 0 :
            self.mainView.frame.width - self.slideInMenuPeddings
        } completion: { finished in
            self.isSlideMenuPresented.toggle()
        }
    }
    
    @objc func signOut(_ button: UIButton) {
        presenter?.signOut()
    }
    
    private func setUpLongPressRecogniser() {
        let longPressRecogniser = UILongPressGestureRecognizer(target: self, action: #selector(dropPinAnnotation(_:)))
        longPressRecogniser.minimumPressDuration = 1.0
        self.mainView.mapView.addGestureRecognizer(longPressRecogniser)
    }
    
    @objc func dropPinAnnotation(_ gestureRecognizer : UIGestureRecognizer){
        presenter?.dropAnnotation(from: gestureRecognizer)
    }
    
}


