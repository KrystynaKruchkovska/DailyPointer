//
//  MapView.swift
//  DailyPointer
//
//  Created by Paweł on 12/07/2022.
//

import Foundation
import MapKit

class MapView: UIView {
    
    init(){
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addSubview(mapView)
        mapView.anchor(canterXAnchor: self.centerXAnchor, canterYAnchor: self.centerYAnchor, widthConstant: self.frame.width, heightConstant: self.frame.height)
    }
    
    var mapView: MKMapView = {
        var map = MKMapView()
        map.showsUserLocation = true
        
        return map
    }()
    
    
}
