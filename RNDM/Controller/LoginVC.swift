//
//  LoginVC.swift
//  RNDM
//
//  Created by Hannie Kim on 12/17/18.
//  Copyright © 2018 Hannie Kim. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {

    // Outlets
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var createUserBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginBtn.layer.cornerRadius = 10
        createUserBtn.layer.cornerRadius = 10

    }
    
    // Login user
    @IBAction func loginBtnTapped(_ sender: Any) {
        guard let email = emailTxt.text,
            let password = passwordTxt.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                debugPrint("Could not sign in: \(error.localizedDescription)")
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func createUserTapped(_ sender: Any) {
        performSegue(withIdentifier: TO_CREATEUSERVC, sender: nil)
    }
}
