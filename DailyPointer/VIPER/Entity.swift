//
//  Entity.swift
//  DailyPointer
//
//  Created by Paweł on 07/07/2022.
//

import Foundation
import Firebase

struct Post: Codable {
    var title:String
    var description:String
    var location: Location
}

struct Location: Codable {
    var lat:Double
    var long:Double
}

struct UserBaseData: Codable {
    var nickname: String
    var email:String
    var password: String
}

protocol FIRUser {
    var email: String? { get }
    var displayName: String? { get }
    var uid: String { get }
    var providerID: String { get }
    var isEmailVerified: Bool { get }
    
    func sendEmailVerification(completion: @escaping (Error?) -> ())
}


class FireBaseUser: FIRUser {
    let user: User
    
    init(user: User) {
        self.user = user
    }

    var email: String? {
        return user.email ?? ""
    }
    
    var displayName: String? {
        return user.displayName ?? ""
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
        user.sendEmailVerification { error in
            completion(error)
        }
    }
    
}
