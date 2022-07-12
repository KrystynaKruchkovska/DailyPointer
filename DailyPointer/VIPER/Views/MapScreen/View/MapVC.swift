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
    
    init(locationManager: AnyLocationManager, user: FIRUser) {
        self.locationManager = locationManager
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let mapView = MapView()
        self.view = mapView
    }
    
}

extension MapViewController: CLLocationManagerDelegate {
    
}
