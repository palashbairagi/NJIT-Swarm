//
//  AddFriendViewController.swift
//  NJIT-Swarm
//
//  Created by Min Zeng on 03/11/2017.
//  Copyright © 2017 Team4. All rights reserved.
//

import UIKit


class AddFriendViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SearchFriendsData.Instance.Data.count
        
    }
    
    @IBOutlet weak var searchTextfield: UITextField!
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseAddFriendCell", for: indexPath) as! addFriendsvwTableViewCell
        cell.index = indexPath.row
        let data = SearchFriendsData.Instance.Data[indexPath.row]
        cell.textLabel?.text = data.username
        cell.detailTextLabel?.text = data.email
        return cell
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var myTablevw: UITableView!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func search(_ sender: Any) {
        if searchTextfield.text != "" {
            SearchFriendsData.Instance.searchFriends(withKey: Constants.EMAIL, value: searchTextfield.text!, handler: { (friends) in
                self.myTablevw.reloadData()
            })
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
