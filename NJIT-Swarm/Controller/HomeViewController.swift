//
//  HomeViewController.swift
//  NJIT-Swarm
//
//  Created by Min Zeng on 02/11/2017.
//  Copyright © 2017 Team4. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class HomeViewController: UIViewController, CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate {
    
    private let PROFILE_PAGE_SEGUE = "profilePage"
    private let FRIEND_PAGE_SEGUE = "friendPage"
    
    @IBOutlet weak var homeMapView: MKMapView!
    @IBOutlet weak var homeTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        FriendsData.Instance.update(handler: nil)
        CheckinsData.Instance.update(handler: nil)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func profile(_ sender: Any) {
        performSegue(withIdentifier: PROFILE_PAGE_SEGUE, sender: nil)
    }
    
    @IBAction func friend(_ sender: Any) {
        performSegue(withIdentifier: FRIEND_PAGE_SEGUE, sender: nil)
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
