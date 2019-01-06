//
//  CreateUserVC.swift
//  RNDM
//
//  Created by Hannie Kim on 12/17/18.
//  Copyright © 2018 Hannie Kim. All rights reserved.
//

import UIKit
import Firebase

class CreateUserVC: UIViewController {

    // Outlets
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var createUserBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createUserBtn.layer.cornerRadius = 10
        cancelBtn.layer.cornerRadius = 10
    }
    
    // Creating the user in Firebase Auth
    @IBAction func createUserTapped(_ sender: Any) {
        
        guard let email = emailTxt.text,
            let password = passwordTxt.text,
            let username = usernameTxt.text else { return }
            
        // Creating a user
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                debugPrint("Error creating user: \(error.localizedDescription)")
            }
            
            // add display name for the user. can use the username elsewhere in our code
            let changeRequest = user?.user.createProfileChangeRequest()
            changeRequest?.displayName = username
            changeRequest?.commitChanges(completion: { (error) in
                if let error = error {
                    debugPrint(error.localizedDescription)
                }
            })
            
            guard let userId = user?.user.uid else { return }
            // add username and date_created to the user using their uid
            Firestore.firestore().collection(USERS_REF).document(userId).setData([
                USERNAME : username,
                DATE_CREATED : FieldValue.serverTimestamp()
                ], completion: { (error) in
                    if let error = error {
                        debugPrint(error.localizedDescription)
                    } else {
                        self.dismiss(animated: true, completion: nil)
                    }
            })
        }
    }
    
    @IBAction func cancelBtnTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
