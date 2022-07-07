//
//  View.swift
//  DailyPointer
//
//  Created by Paweł on 07/07/2022.
//

import Foundation
import UIKit
import MapKit

protocol AnyView {
    var presenter: AnyPresenter? { get set }
}

class RootViewController: UIViewController, AnyView {
    var presenter: AnyPresenter?
    var locationManager: AnyLocationManager {
        didSet {
            locationManager.delegate = self
        }
    }
    
    init(locationManager: AnyLocationManager) {
        self.locationManager = locationManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .orange
        self.view = mapView
    }
    
    override func viewDidLayoutSubviews() {
        self.mapView.frame = view.bounds
    }
    
    
    var mapView: MKMapView = {
        var map = MKMapView()
        map.showsUserLocation = true
        
        return map
    }()
}

extension RootViewController: CLLocationManagerDelegate {
    
}
