//
//  ProfileViewController.swift
//  NJIT-Swarm
//
//  Created by Min Zeng on 02/11/2017.
//  Copyright © 2017 Team4. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var editBtn: UIBarButtonItem!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var userNameTextfield: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    private var editMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func edit(_ sender: Any) {
        if editMode == false {
            editMode = true
            editBtn.title = "Done"
            emailTextfield.allowsEditingTextAttributes = true
            passwordTextfield.allowsEditingTextAttributes = true
            userNameTextfield.allowsEditingTextAttributes = true
            phoneTextField.allowsEditingTextAttributes = true
        } else {
            editMode = false
            editBtn.title = "Edit"
            emailTextfield.allowsEditingTextAttributes = false
            passwordTextfield.allowsEditingTextAttributes = false
            userNameTextfield.allowsEditingTextAttributes = false
            phoneTextField.allowsEditingTextAttributes = false
        }
    } // edit
    
    @IBAction func logout(_ sender: Any) {
        
    } // logout
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    } // back
    
}
