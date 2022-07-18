//
//  LocationManager.swift
//  DailyPointer
//
//  Created by Paweł on 07/07/2022.
//

import Foundation
import CoreLocation
import Combine

class DeviceLocationService: NSObject, CLLocationManagerDelegate {
    
    var coordinatesPublisher = PassthroughSubject<CLLocationCoordinate2D, Error>()
    var deniedLocationAccessPublisher = PassthroughSubject<Void,Never>()
    static let shared = DeviceLocationService()
    
    private override init() {
        super.init()
    }
    
    private lazy var locationManager: CLLocationManager = {
        var manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        manager.startMonitoringSignificantLocationChanges()
        manager.startUpdatingLocation()
        return manager
    }()
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        manager.stopUpdatingLocation()
        coordinatesPublisher.send(location.coordinate)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        coordinatesPublisher.send(completion: .failure(error))
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        default:
            manager.startUpdatingLocation()
            deniedLocationAccessPublisher.send()
        }
    }
    
    func requestLocationUpdates() {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        default:
            deniedLocationAccessPublisher.send()
        }
    }
}
