//
//  LocationManager.swift
//  DailyPointer
//
//  Created by Paweł on 07/07/2022.
//

import Foundation
import CoreLocation

protocol AnyLocationManager {
    var locationManager: CLLocationManager { get set }
    var authorizationStatus: CLAuthorizationStatus { get }
    var isLocationAuthorized: Bool { get }
    var delegate: CLLocationManagerDelegate? { get set }
    func setAppLocation()
}

extension AnyLocationManager {
    var authorizationStatus: CLAuthorizationStatus {
        return locationManager.authorizationStatus
    }
    
    var isLocationAuthorized: Bool {
        switch authorizationStatus {
        case .restricted, .denied, .notDetermined:
            return false
        default:
            return true
        }
    }
}

class LacationManager: AnyLocationManager {
    var delegate: CLLocationManagerDelegate?
    
    
    var locationManager: CLLocationManager
    
    init(delegate: CLLocationManagerDelegate? = nil) {
        locationManager = CLLocationManager()
        self.delegate = delegate
        setAppLocation()
    }
    
    func setAppLocation() {
        if isLocationAuthorized {
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.delegate = delegate
            locationManager.startUpdatingLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
}
