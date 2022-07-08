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

struct User: Codable {
    var nickname: String
    var email:String
    var password: String
}

protocol AnyFirebaseUser {
    var email: String { get }
    var nickname: String { get }
    var uid: String { get }
    var providerID: String { get }
    var isEmailVerified: Bool { get }
    
    func sendEmailVerification(completion: @escaping (Error?) -> ())
}

class FireBaseUser: AnyFirebaseUser {
    let user: AnyFirebaseUser
    
    init(user: AnyFirebaseUser) {
        self.user = user
    }

    var email: String {
        return user.email
    }
    
    var nickname: String {
        return ""
    }
    
    var uid: String {
        return user.uid
    }
    
    var providerID: String {
        return user.providerID
    }
    
    var isEmailVerified: Bool {
        return user.isEmailVerified
    }
    
    func sendEmailVerification(completion: @escaping (Error?) -> ()) {
        
    }
    
}
