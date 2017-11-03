//
//  LoginViewController.swift
//  NJIT-Swarm
//
//  Created by Min Zeng on 01/11/2017.
//  Copyright © 2017 Team4. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let HOME_PAGE_SEGUE = "homePage"
    private let SIGN_UP_SEGUE = "signUpPage"

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {}
    
    @IBAction func login(_ sender: Any) {
        if emailTextField.text != "" && passwordTextField.text != "" {
            AuthProvider.Instance.login(email: emailTextField.text!, password: passwordTextField.text!, authHandler: { (message) in
                if message != nil {
                    self.showAlert(message: message!)
                } else {
                    self.emailTextField.text = ""
                    self.passwordTextField.text = ""
                    self.performSegue(withIdentifier: self.HOME_PAGE_SEGUE, sender: nil)
                }
            })
        } else {
            showAlert(message: AUTH_ERROR_MESSAGE.EMAIL_PASSWORD_EMPTY)
        }
    } // login
    
    @IBAction func signUp(_ sender: Any) {
//        if emailTextField.text != "" && passwordTextField.text != "" {
//            AuthProvider.Instance.signUp(email: emailTextField.text!, password: passwordTextField.text!, authHandler: { (message) in
//                if message != nil {
//                    self.showAlert(message: message!)
//                } else {
//                    self.login(sender)
//                }
//            })
//        } else {
//            showAlert(message: AUTH_ERROR_MESSAGE.EMAIL_PASSWORD_EMPTY)
//        }
        performSegue(withIdentifier: SIGN_UP_SEGUE, sender: nil)
    } // signUp
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    

}
