//
//  Entity.swift
//  DailyPointer
//
//  Created by Paweł on 07/07/2022.
//

import Foundation

struct Post: Codable {
    
    var title:String
    var description:String
    var location: Location
}

struct Location: Codable {
    var lat:Double
    var long:Double
}
