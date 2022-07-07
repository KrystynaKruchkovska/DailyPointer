//
//  FirebaseService.swift
//  DailyPointer
//
//  Created by Paweł on 07/07/2022.
//

import Foundation

protocol AnyFirebaseService {
    var clientID: String { get }
    var credential: String { get }
}
