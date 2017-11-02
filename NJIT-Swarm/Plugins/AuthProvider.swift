//
//  AuthProvider.swift
//  NJIT-Swarm
//
//  Created by Min Zeng on 01/11/2017.
//  Copyright © 2017 Team4. All rights reserved.
//

import Foundation
import FirebaseAuth

typealias AuthHandler = (_ msg: String?) -> Void

struct AUTH_ERROR_MESSAGE {
    static let EMAIL_IN_USE = "Email Already In Use"
    static let WRONG_PASSWORD = "Wrong Password"
    static let USER_NOT_FOUND = "User Not Found"
    static let INVALID_EMAIL = "Invalid email"
    static let EMAIL_PASSWORD_EMPTY = "Email OR Password Is Empty"
    static let LOGOUT_FAILED = "Logout Failed"
    static let DEFAULT = "Unknown Error"
}

class AuthProvider {
    private static let _instance = AuthProvider()
    private init() {}
    static var Instance: AuthProvider {
        return _instance
    }
    
    func login(email: String, password: String, authHandler: AuthHandler?) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                self.handleError(withError: error! as NSError, authHandler: authHandler)
            } else {
                authHandler?(nil)
            }
        }
    }
    
    func signUp(email: String, password: String, authHandler: AuthHandler?) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if (error != nil) {
                self.handleError(withError: error! as NSError, authHandler: authHandler)
            } else {
                authHandler?(nil)
            }
        }
    }
    
    func logout() -> Bool {
        if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()
                return true
            } catch {
                return false
            }
        }
        return true
    }
    
    func handleError(withError: NSError, authHandler: AuthHandler?) {
        if let errorCode = AuthErrorCode(rawValue: withError.code) {
            switch errorCode {
            case AuthErrorCode.emailAlreadyInUse:
                authHandler?(AUTH_ERROR_MESSAGE.EMAIL_IN_USE)
                break
            case AuthErrorCode.wrongPassword:
                authHandler?(AUTH_ERROR_MESSAGE.WRONG_PASSWORD)
                break
            case AuthErrorCode.userNotFound:
                authHandler?(AUTH_ERROR_MESSAGE.USER_NOT_FOUND)
                break
            case AuthErrorCode.invalidEmail:
                authHandler?(AUTH_ERROR_MESSAGE.INVALID_EMAIL)
                break
            default:
                authHandler?(AUTH_ERROR_MESSAGE.DEFAULT)
            }
        }
    }
}