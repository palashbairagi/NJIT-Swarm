//
//  DataStructure.swift
//  NJIT-Swarm
//
//  Created by Min Zeng on 04/11/2017.
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

typealias CheckinDataHandler = (_ data: Array<CheckinData>) -> Void

struct FriendData {
    var uid = ""
    var username = ""
    var phone = ""
    var email = ""
}

typealias FriendDataHandler = (_ data: Array<FriendData>) -> Void
