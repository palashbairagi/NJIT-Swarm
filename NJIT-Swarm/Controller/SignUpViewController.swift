//
//  SignUpViewController.swift
//  NJIT-Swarm
//
//  Created by Min Zeng on 02/11/2017.
//  Copyright © 2017 Team4. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    let SIGNUP_TO_HOME_SEGUE = "signupToHome"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var nameTxt: UITextField!
    
    @IBOutlet weak var emailTxt: UITextField!
    
    @IBOutlet weak var passwordTxt: UITextField!
    
    @IBOutlet weak var phoneNumTxt: UITextField!
    
    @IBAction func registerBtn(_ sender: Any) {
        if emailTxt.text != "" && passwordTxt.text != "" && nameTxt.text != "" && phoneNumTxt.text != "" {
            AuthProvider.Instance.signUp(email: emailTxt.text!, password: passwordTxt.text!, username: nameTxt.text!, phone: phoneNumTxt.text!, authHandler: { (message) in
                if message != nil {
                    self.showAlert(message: message!)
                } else {
                    self.login()
                }
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
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func login() {
        if emailTxt.text != "" && passwordTxt.text != "" {
            AuthProvider.Instance.login(email: emailTxt.text!, password: passwordTxt.text!, authHandler: { (message) in
                if message != nil {
                    self.showAlert(message: message!)
                } else {
                    self.performSegue(withIdentifier: self.SIGNUP_TO_HOME_SEGUE, sender: nil)
                }
            })
        }
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
}
