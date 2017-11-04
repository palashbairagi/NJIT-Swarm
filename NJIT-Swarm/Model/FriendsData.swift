//
//  FriendsData.swift
//  NJIT-Swarm
//
//  Created by Min Zeng on 03/11/2017.
//  Copyright © 2017 Team4. All rights reserved.
//

import Foundation

class FriendsData {
    private static let _instance = FriendsData()
    private init() {}
    static var Instance: FriendsData {
        return _instance
    }
    
    private var _data = Array<FriendData>()
    var Data: Array<FriendData> {
        get {
            return _data
        }
    }
    
    func update(handler: FriendDataHandler?) {
        _data.removeAll()
        DBProvider.Instance.getAllUsers { (usersData) in
            DBProvider.Instance.getFriends(withID: AuthProvider.Instance.getUserID()!, dataHandler: { (friendsData) in
                if usersData != nil && friendsData != nil {
                    for uData in usersData! {
                        for fData in friendsData! {
                            if uData.key == fData.key {
                                var newData = FriendData()
                                newData.uid = uData.key
                                if let data = uData.value as? [String: Any] {
                                    if let email = data[Constants.EMAIL] as? String {
                                        newData.email = email
                                    }
                                    if let name = data[Constants.USERNAME] as? String {
                                        newData.username = name
                                    }
                                    if let phone = data[Constants.PHONE] as? String {
                                        newData.phone = phone
                                    }
                                }
                                self._data.append(newData)
                            }
                        }
                    }
                }
                handler?(self._data)
            })
        }
    }
}
