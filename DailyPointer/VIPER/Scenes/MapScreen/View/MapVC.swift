//
//  View.swift
//  DailyPointer
//
//  Created by Paweł on 07/07/2022.
//

import Foundation
import UIKit
import MapKit

protocol MapViewProtocol {
    var presenter: MapPresenterProtocol? { get set }
}

class MapViewController: UIViewController, MapViewProtocol {
    var user: FIRUser
    var presenter: MapPresenterProtocol?
    var locationManager: AnyLocationManager {
        didSet {
            locationManager.delegate = self
        }
    }
    
    private var mapView: MapView {
        return view as! MapView
    }
    
    init(locationManager: AnyLocationManager, user: FIRUser) {
        self.locationManager = locationManager
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        let mapView = MapView()
        self.view = mapView
    }
    
    override func viewDidLayoutSubviews() {
        self.navigationItem.hidesBackButton = true
        mapView.signOutButton.addTarget(self, action: #selector(signOut(_:)), for: .touchDown)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func signOut(_ button: UIButton) {
        presenter?.signOut()
    }
    
}

extension MapViewController: CLLocationManagerDelegate {
    
}
