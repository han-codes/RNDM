//
//  LoginVC.swift
//  RNDM
//
//  Created by Hannie Kim on 12/17/18.
//  Copyright © 2018 Hannie Kim. All rights reserved.
//

import UIKit

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
    @IBAction func loginBtnTapped(_ sender: Any) {
    }
    
    @IBAction func createUserTapped(_ sender: Any) {
        
    }
}
