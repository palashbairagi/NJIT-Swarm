//
//  ProfileViewController.swift
//  NJIT-Swarm
//
//  Created by Min Zeng on 02/11/2017.
//  Copyright © 2017 Team4. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private let CAN_NOT_BE_EMPTY = "It Can Not Be Empty"
    private let LOAD_DATA_FAILED = "Load Data Failed"
    private let LOGOUT_FAILED = "Logout Failed"

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var userNameTextfield: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    private var editMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        loadUserData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadUserData() {
        DBProvider.Instance.getUserData(withID: AuthProvider.Instance.getUserID()!) { (data) in
            if data != nil {
                if let email = data![Constants.EMAIL] as? String {
                    self.emailTextfield.text = email
                }
                if let password = data![Constants.PASSWORD] as? String {
                    self.passwordTextfield.text = password
                }
                if let username = data![Constants.USERNAME] as? String {
                    self.userNameTextfield.text = username
                }
                if let phone = data![Constants.PHONE] as? String {
                    self.phoneTextField.text = phone
                }
            } else {
                self.showAlert(message: self.LOAD_DATA_FAILED)
            }
        }
    }
    
    @IBAction func logout(_ sender: Any) {
        if AuthProvider.Instance.logout() {
            self.performSegue(withIdentifier: "unwindToViewController", sender: self)
        } else {
            showAlert(message: LOGOUT_FAILED)
        }
    } // logout
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    } // back
    
    @IBAction func editEmail(_ sender: Any) {
        if emailTextfield.isEnabled {
            if emailTextfield.text != "" {
                AuthProvider.Instance.updateEmail(email: emailTextfield.text!, authHandler: { (message) in
                    if message != nil {
                        self.showAlert(message: message!)
                    } else {
                        DBProvider.Instance.updateUserDate(data: [Constants.EMAIL: self.emailTextfield.text!])
                        self.emailTextfield.isEnabled = false
                        self.emailTextfield.endEditing(true)
                        let btn = sender as! UIButton
                        btn.setTitle("Edit", for: .normal)
                    }
                })
            } else {
                showAlert(message: CAN_NOT_BE_EMPTY)
            }
        } else {
            emailTextfield.isEnabled = true
            let btn = sender as! UIButton
            btn.setTitle("Done", for: .normal)
        }
    }
    
    @IBAction func editPassword(_ sender: Any) {
        if passwordTextfield.isEnabled {
            if passwordTextfield.text != "" {
                AuthProvider.Instance.updatePassword(password: passwordTextfield.text!, authHandler: { (message) in
                    if message != nil {
                        self.showAlert(message: message!)
                    } else {
                        DBProvider.Instance.updateUserDate(data: [Constants.PASSWORD: self.passwordTextfield.text!])
                        self.passwordTextfield.isEnabled = false
                        self.passwordTextfield.endEditing(true)
                        let btn = sender as! UIButton
                        btn.setTitle("Edit", for: .normal)
                    }
                })
            } else {
                showAlert(message: CAN_NOT_BE_EMPTY)
            }
        } else {
            passwordTextfield.isEnabled = true
            let btn = sender as! UIButton
            btn.setTitle("Done", for: .normal)
        }
    }
    
    @IBAction func EditName(_ sender: Any) {
        if userNameTextfield.isEnabled {
            if userNameTextfield.text != nil {
                DBProvider.Instance.updateUserDate(data: [Constants.USERNAME: userNameTextfield.text!])
                self.userNameTextfield.isEnabled = false
                self.userNameTextfield.endEditing(true)
                let btn = sender as! UIButton
                btn.setTitle("Edit", for: .normal)
            } else {
                showAlert(message: CAN_NOT_BE_EMPTY)
            }
        } else {
            userNameTextfield.isEnabled = true
            let btn = sender as! UIButton
            btn.setTitle("Done", for: .normal)
        }
    }
    
    @IBAction func EditPhone(_ sender: Any) {
        if phoneTextField.isEnabled {
            if phoneTextField.text != nil {
                DBProvider.Instance.updateUserDate(data: [Constants.PHONE: phoneTextField.text!])
                self.phoneTextField.isEnabled = false
                self.phoneTextField.endEditing(true)
                let btn = sender as! UIButton
                btn.setTitle("Edit", for: .normal)
            } else {
                showAlert(message: CAN_NOT_BE_EMPTY)
            }
        } else {
            phoneTextField.isEnabled = true
            let btn = sender as! UIButton
            btn.setTitle("Done", for: .normal)
        }
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
}
