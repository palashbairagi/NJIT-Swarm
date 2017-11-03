//
//  DBProvider.swift
//  NJIT-Swarm
//
//  Created by Min Zeng on 02/11/2017.
//  Copyright © 2017 Team4. All rights reserved.
//

import Foundation
import FirebaseDatabase

typealias DataHandler = (_ data: [String: Any]?) -> Void

class DBProvider {
    private static let _instance = DBProvider()
    private init () {}
    static var Instance: DBProvider {
        return _instance
    }
    var dbRef: DatabaseReference {
        return Database.database().reference()
    }
    
    var userRef: DatabaseReference {
        return dbRef.child(Constants.USER)
    }
    
    var checkinRef: DatabaseReference {
        return dbRef.child(Constants.CHECKIN)
    }
    
    func saveUser(withID: String, email: String, password: String, username: String, phone: String) {
        let data: Dictionary<String, Any> = [Constants.EMAIL: email, Constants.PASSWORD: password, Constants.USERNAME: username, Constants.PHONE: phone]
        userRef.child(withID).setValue(data)
    }
    
    func updateUserDate(data: Dictionary<String, Any>) {
        if let uid = AuthProvider.Instance.getUserID() {
            userRef.child(uid).updateChildValues(data)
        }
    }
    
    /*
     Get user by uid
     
     Return data should be: [String: Any]
     Like [username: min, email: min@mail.com, ... ]
     */
    func getUserData(withID: String, dataHandler: DataHandler?) {
        userRef.child(withID).observeSingleEvent(of: .value) { (snapshot) in
            if let value = snapshot.value {
                let data = value as! [String: Any]
                dataHandler?(data)
            } else {
                dataHandler?(nil)
            }
        }
    }
    
    /*
     Search users by name, phone, etc.
     withKey: see "Constants.swift" keys for user
     
     Return data should be: [String: [String: Any]]
     Like [uid1: [username: min, email: min@mail.com, ... ], uid2: [username: asha, email: asha@mail.com, ...], ...]
     */
    func getUsers(withKey: String, value: Any, dataHandler: DataHandler?) {
        userRef.queryOrdered(byChild: withKey).queryEqual(toValue: value).observeSingleEvent(of: .value) { (snapshot) in
            if let value = snapshot.value {
                let data = value as! [String: Any]
                dataHandler?(data)
            } else {
                dataHandler?(nil)
            }
        }
    }
    
    func saveCheckin(withID: String, place: String, latitude: Double, longitude: Double) {
        let data: Dictionary<String, Any> = [Constants.UID: withID, Constants.PLACE: place, Constants.LATITUDE: latitude, Constants.LONGITUDE: longitude, Constants.TIMESTAMP: ServerValue.timestamp()]
        checkinRef.childByAutoId().setValue(data)
    }
    
    func getCheckins(dataHandler: DataHandler?) {
        checkinRef.queryOrdered(byChild: Constants.TIMESTAMP).queryLimited(toLast: 100).observeSingleEvent(of: .value) { (snapshot) in
            if let value = snapshot.value {
                let data = value as! [String: Any]
                dataHandler?(data)
            } else {
                dataHandler?(nil)
            }
        }
    }
    
    func getCheckins(withID: String, dataHandler: DataHandler?) {
        checkinRef.queryOrdered(byChild: Constants.TIMESTAMP).queryEqual(toValue: withID, childKey: Constants.UID).observeSingleEvent(of: .value) { (snapshot) in
            if let value = snapshot.value {
                let data = value as! [String: Any]
                dataHandler?(data)
            } else {
                dataHandler?(nil)
            }
        }
    }
    
    
} // class
