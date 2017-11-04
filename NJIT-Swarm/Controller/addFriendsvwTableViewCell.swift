//
//  addFriendsvwTableViewCell.swift
//  NJIT-Swarm
//
//  Created by Asha Vatalia on 11/4/17.
//  Copyright © 2017 Team4. All rights reserved.
//

import UIKit

class addFriendsvwTableViewCell: UITableViewCell {
    private var _index = 0
    var index: Int {
        get {
            return _index
        }
        set {
            _index = newValue
        }
    }
    
    @IBAction func add(_ sender: Any) {
        let data = SearchFriendsData.Instance.Data[index]
        DBProvider.Instance.saveFriend(withID: AuthProvider.Instance.getUserID()!, friendID: data.uid)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
