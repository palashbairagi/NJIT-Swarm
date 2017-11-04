//
//  CheckinsData.swift
//  NJIT-Swarm
//
//  Created by Min Zeng on 03/11/2017.
//  Copyright © 2017 Team4. All rights reserved.
//

import Foundation

struct CheckinData {
    var place = ""
    var latitude = Double()
    var longitute = Double()
    var uid = ""
    var timestamp = Date()
    var message = ""
    var username = ""
}

typealias CheckinsDataUpdataHandler = (_ data: Array<CheckinData>) -> Void

class CheckinsData {
    private static let _instance = CheckinsData()
    private init() {}
    static var Instance: CheckinsData {
        return _instance
    }
    
    var _data = Array<CheckinData>()
    var Data: Array<CheckinData> {
        get {
            return _data
        }
    }
    
    // get all friends and current user's checkins data
    func update(handler: CheckinsDataUpdataHandler?) {
        _data.removeAll()
        DBProvider.Instance.getCheckins { (checkinsData) in
            if checkinsData != nil {
                for checkinData in checkinsData! {
                    if let cData = checkinData.value as? [String: Any] {
                        for fData in FriendsData.Instance.Data {
                            if let cUid = cData[Constants.UID] as? String {
                                if cUid == fData.uid || cUid == AuthProvider.Instance.getUserID() {
                                    var newData = CheckinData()
                                    if let latitude = cData[Constants.LATITUDE] as? Double {
                                        newData.latitude = latitude
                                    }
                                    if let longitute = cData[Constants.LONGITUDE] as? Double {
                                        newData.longitute = longitute
                                    }
                                    if let place = cData[Constants.PLACE] as? String {
                                        newData.place = place
                                    }
                                    if let uid = cData[Constants.UID] as? String {
                                        newData.uid = uid
                                    }
                                    if let message = cData[Constants.MESSAGE] as? String {
                                        newData.message = message
                                    }
                                    if let timestamp = cData[Constants.TIMESTAMP] as? Date {
                                        newData.timestamp = timestamp
                                    }
                                    newData.username = fData.username
                                    self._data.append(newData)
                                }
                            }
                        }
                    }
                }
            }
            handler?(self._data)
        }
    }
}
