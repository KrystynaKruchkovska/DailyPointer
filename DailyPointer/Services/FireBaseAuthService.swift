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
    case inappropriateCredentials
}

enum AuthTypes {
    case email
    case facebook
    case google
}


protocol AnyCredetials {
    
}
protocol AuthServiceProtocol {
    func singIn(with authType: AuthTypes, credentials: AnyCredetials, handler: @escaping (Result<FireBaseUser,Error>)->())
    func createNewAccount(user: UserBaseData, handler: @escaping (Result<FIRUser, Error>) -> ())
    func sendVerificationEmail(user:FIRUser, handler:@escaping (_ error:Error?)->())
    func signOut(handler: @escaping (Error?)->())
    func resetPassword(email: String, handler: @escaping (_ error:Error?) -> ())
}

struct FacebookCredentials: AnyCredetials {
    
}
struct EmailCredentials: AnyCredetials {
    var email: String
    var password: String
}
struct GoogleCredentials: AnyCredetials {
    
}


class FirebaseAuthService: AuthServiceProtocol {
    
    static let shared = FirebaseAuthService()
    
    private init() {}
    
    func singIn(with authType: AuthTypes, credentials: AnyCredetials, handler: @escaping (Result<FireBaseUser,Error>)->()) {
        
        switch authType {
        case .email:
            guard let credentials = credentials as? EmailCredentials else {
                handler(.failure(Errors.inappropriateCredentials))
                return
            }
            Auth.auth().signIn(withEmail: credentials.email, password: credentials.password) { (authResult, error) in
                
                if let user = authResult?.user {
                    handler(.success(FireBaseUser(user: user)))
                }
                
                if let error = error {
                    handler(.failure(error))
                }

            }
        case .facebook:
            print("facebook")
//            guard let credentials = credentials as? FacebookCredentials else {
//                handler(.failure(Errors.inappropriateCredentials))
//            }
//            Auth.auth().signInAndRetrieveData(with: credentials)
        case .google:
            print("google")
        }
        
    }
    
    func signOut(handler: @escaping (Error?)->()) {
        do {
            try Auth.auth().signOut()
            handler(nil)
        } catch let signOutError {
            handler(signOutError)
        }
    }
    
    func createNewAccount(user: UserBaseData, handler: @escaping (Result<FIRUser, Error>) -> ()) {
        Auth.auth().createUser(withEmail: user.email, password: user.password) { (authResult, error) in
            if let error = error {
                print("create user error: \(error)")
                handler(Result.failure(error))
                return
            }
            guard let user = authResult?.user  else {
                handler(Result.failure(Errors.failedGetUser))
                return
            }
            handler(Result.success(FireBaseUser(user: user)))
        }
    }
    
    func sendVerificationEmail(user:FIRUser, handler:@escaping (_ error:Error?)->()) {
        user.sendEmailVerification { error in
            handler(error)
        }
     }
    
    func resetPassword(email: String, handler: @escaping (_ error:Error?) -> ()) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            handler(error)
        }
    }
}
