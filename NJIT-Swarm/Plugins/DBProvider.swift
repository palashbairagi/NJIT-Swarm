//
//  DBProvider.swift
//  NJIT-Swarm
//
//  Created by Min Zeng on 02/11/2017.
//  Copyright © 2017 Team4. All rights reserved.
//

import Foundation
import FirebaseDatabase

class DBProvider {
    private static let _instance = DBProvider()
    private init () {}
    static var Instance: DBProvider {
        return _instance
    }
    var dbRef:DatabaseReference {
        return Database.database().reference()
    }
    
    var userRef:DatabaseReference {
        return dbRef.child(Constants.USER)
    }
    
    func saveUser(withID: String, email: String, password: String, username: String, phone: String) {
        let data: Dictionary<String, Any> = [Constants.EMAIL: email, Constants.PASSWORD: password, Constants.USERNAME: username, Constants.PHONE: phone]
        userRef.child(withID).child(Constants.USERDATA).setValue(data)
    }
    
} // class
