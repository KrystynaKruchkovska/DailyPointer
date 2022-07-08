//
//  FireBaseAuthService.swift
//  DailyPointer
//
//  Created by Paweł on 08/07/2022.
//

import Foundation
import Firebase

enum Errors: Error {
    case failedGetUser
}

enum AuthTypes {
    case email
    case facebook
    case google
}

enum UserCredentials {
    case email
    
    var getCredentials: AnyCredetials {
        switch self {
        case .email:
            return EmailCredentials()
        }
    }
}

protocol AnyCredetials {
    
}
protocol AnyFirebaseAuthService {
    func singIn(with: AuthTypes, credentials: UserCredentials)
    func createNewAccount(user: User, handler: @escaping (Result<AnyFirebaseUser, Error>) -> ())
}

struct FacebookCredentials: AnyCredetials {
    
}
struct EmailCredentials: AnyCredetials {
    
}
struct GoogleCredentials: AnyCredetials {
    
}


class FirebaseAuthService: AnyFirebaseAuthService {
    func singIn(with: AuthTypes, credentials: UserCredentials) {
        
    }
    
    func createNewAccount(user: User, handler: @escaping (Result<AnyFirebaseUser, Error>) -> ()){
        Auth.auth().createUser(withEmail: user.email, password: user.password){ (authResult, error) in
            if let error = error {
                print("create user error: \(error)")
                handler(Result.failure(error))
                
                return
            }
            
            guard let user = authResult?.user  else {
                handler(Result.failure(Errors.failedGetUser))
                return
            }
            
            if let userF = user as? AnyFirebaseUser {
                handler(Result.success(FireBaseUser(user: userF)))
            }
            
        }
        
    }
}
