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
    
    var user: FIRUser
    var presenter: MapPresenterProtocol?
    var mainView: MapView {
        return view as! MapView
    }
        
    init(user: FIRUser) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        self.view = MapView()
    }
    
    override func viewDidLayoutSubviews() {
        self.navigationItem.hidesBackButton = true
        mainView.signOutButton.addTarget(self, action: #selector(signOut(_:)), for: .touchDown)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLongPressRecogniser()
        mainView.mapView.delegate = presenter
        presenter?.observeDeviceLocationService()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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


