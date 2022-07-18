//
//  MapPresenter.swift
//  DailyPointer
//
//  Created by Paweł on 12/07/2022.
//

import Combine
import Foundation
import MapKit
import CoreLocation

protocol MapPresenterProtocol: CLLocationManagerDelegate, MKMapViewDelegate {
    var view: MapViewProtocol? { get set }
    var router: MapRouterProtocol? { get set }
    var interactor: MapInteractorProtocol? { get set }
    func signOut()
    func dropAnnotation(from gestureRecognizer: UIGestureRecognizer)
    func observeDeviceLocationService()
}

class MapPresenter: NSObject, MapPresenterProtocol {
    var interactor: MapInteractorProtocol?
    var view: MapViewProtocol?
    var router: MapRouterProtocol?
    
    var tokens: Set<AnyCancellable> = []
    fileprivate var deviceLocationService = DeviceLocationService.shared

    private var gesturePinAnnotation: CustomPin!

    func signOut() {
        interactor?.signOut(handler: { [weak self] error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.router?.showAlertVC(title: "Opps", messsage: error.localizedDescription, actions: nil)
                } else {
                    self?.router?.showLoginViewController()
                }
            }
        })
    }
    
    @objc func dropAnnotation(from gestureRecognizer: UIGestureRecognizer) {
            
        if gestureRecognizer.state != .began { return }
//        self.removeGestureAddedPinAnnotation()
        
        let touchPoint = gestureRecognizer.location(in: view?.mainView.mapView)
        guard let touchMapCoordinate = view?.mainView.mapView.convert(touchPoint, toCoordinateFrom: view?.mainView.mapView) else {
            return
        }
    
        let pinAnnotation = CustomPin(coordinate: Location(lat: touchMapCoordinate.latitude, long: touchMapCoordinate.longitude),
                                      title: "Create post",
                                      uid: UUID().uuidString)
            
        view?.mainView.addPin(annotation: pinAnnotation)
         
        }
}

extension MapPresenter: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil
        }
        
        let button = UIButton(type: .infoLight)
        
        let pinAnnotation = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Custom")
        pinAnnotation.animatesDrop = true
        pinAnnotation.canShowCallout = true
        pinAnnotation.rightCalloutAccessoryView = button
        
        return pinAnnotation
        
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {

        guard let annotation = view.annotation as? CustomPin,
              control == view.rightCalloutAccessoryView else {
            return
        }
        print("[HERE]\(String(describing: annotation.uid))")
        
    }
}

extension MapPresenter {
    
    func observeCoordinateUpdates() {
        deviceLocationService.coordinatesPublisher
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case . finished:
                    print("Publisher stopped observing")
                case .failure(let error):
                    print("[ERROR]\(error)")
                }
        } receiveValue: { [weak self] location in
            self?.render(location)
            print("[WOW]\(location.longitude)" + "\(location.latitude)")
        }
        .store(in: &tokens)
    }
    
    func observeLocationAccessDenied() {
        deviceLocationService.deniedLocationAccessPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.router?.showAlertVC(title: "Opps", messsage: "Allow location access insettings", actions: nil)
            }
            .store(in: &tokens)
    }
    
    func observeDeviceLocationService() {
        observeCoordinateUpdates()
        observeLocationAccessDenied()
        deviceLocationService.requestLocationUpdates()
    }
    
    func render(_ coordinate: CLLocationCoordinate2D) {
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region: MKCoordinateRegion = MKCoordinateRegion(center: coordinate, span: span)
        view?.mainView.mapView.setRegion(region, animated: true)
    }
}
