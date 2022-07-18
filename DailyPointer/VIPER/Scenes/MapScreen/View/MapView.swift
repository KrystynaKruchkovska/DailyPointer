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
        self.backgroundColor = .systemYellow
        mapView.addSubview(signOutButton)
        signOutButton.anchor(top: mapView.safeAreaLayoutGuide.topAnchor, right: mapView.safeAreaLayoutGuide.rightAnchor, rightConstant: 16, widthConstant: 50, heightConstant: 50)
        self.addSubview(mapView)
        mapView.anchor(canterXAnchor: self.centerXAnchor,
                       canterYAnchor: self.centerYAnchor,
                       top: self.topAnchor,
                       bottom: self.bottomAnchor,
                       left: self.leftAnchor,
                       right: self.rightAnchor)
    }
    
    var mapView: MKMapView = {
        var map = MKMapView()
        map.showsUserLocation = true
        
        return map
    }()
    
    var signOutButton: UIButton = {
        var image = UIImage(systemName: "rectangle.portrait.and.arrow.right")
        
        var button = UIButton(type: .custom)
        button.setImage(image, for: .normal)
        button.imageView?.layer.transform = CATransform3DMakeScale(1.2, 1.2, 1.2)
        button.clipsToBounds = true
        button.tintColor = .systemYellow

        return button
    }()
    
    func addPin(annotation: CustomPin) {
        mapView.addAnnotation(annotation)
    }
}
