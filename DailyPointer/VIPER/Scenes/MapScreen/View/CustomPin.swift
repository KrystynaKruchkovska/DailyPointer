//
//  CustomPin.swift
//  DailyPointer
//
//  Created by Paweł on 15/07/2022.
//

import Foundation
import MapKit

class CustomPin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var uid: String?
    
    init(coordinate: Location, title: String?, uid: String?) {
        self.coordinate = CLLocationCoordinate2D(latitude: coordinate.lat, longitude: coordinate.long)
        self.title = title
        self.uid = uid
    }
}
