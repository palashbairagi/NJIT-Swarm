//
//  HomePageViewController.swift
//  NJIT-Swarm
//
//  Created by Min Zeng on 01/11/2017.
//  Copyright © 2017 Team4. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logout(_ sender: Any) {
        if AuthProvider.Instance.logout() {
            dismiss(animated: true, completion: nil);
        } else {
            showAlert(message: AUTH_ERROR_MESSAGE.LOGOUT_FAILED)
        }
    }
    
    @IBAction func profile(_ sender: Any) {
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }

}
