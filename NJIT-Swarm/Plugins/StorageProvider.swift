//
//  StorageProvider.swift
//  NJIT-Swarm
//
//  Created by Min Zeng on 04/11/2017.
//  Copyright © 2017 Team4. All rights reserved.
//

import Foundation
import FirebaseStorage

typealias UploadHandler = (_ success: Bool) -> Void

class StorageProvider {
    private static let _instance = StorageProvider()
    private init() {}
    static var Instance: StorageProvider {
        return _instance
    }
    
    var storageRef: StorageReference {
        return Storage.storage().reference(forURL: "gs://njit-swarm.appspot.com/")
    }
    var userRef: StorageReference {
        return storageRef.child(Constants.USER)
    }
    var placeRef: StorageReference {
        return storageRef.child(Constants.PLACE)
    }
    
    func uploadProfilePic(image: Data?, uid: String, handler: UploadHandler?) {
        userRef.child("\(uid).jpg").putData(image!, metadata: nil) { (metadata, error) in
            if error != nil {
                handler?(false)
            } else {
                handler?(true)
            }
        }
    }
    
    func uploadProfilePic(url: URL?, uid: String, handler: UploadHandler?) {
        userRef.child("\(uid).jpg").putFile(from: url!, metadata: nil) { (metadata, error) in
            if error != nil {
                handler?(false)
            } else {
                handler?(true)
            }
        }
    }
    
    func getProfilePicUrl(uid: String) -> String {
        return userRef.child("\(uid).jpg").fullPath
    }
}
