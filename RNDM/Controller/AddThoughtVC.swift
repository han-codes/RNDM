//
//  AddThoughtVC.swift
//  RNDM
//
//  Created by Hannie Kim on 11/14/18.
//  Copyright © 2018 Hannie Kim. All rights reserved.
//

import UIKit
import Firebase

class AddThoughtVC: UIViewController, UITextViewDelegate {

    // Outlets
    @IBOutlet private weak var categorySegment: UISegmentedControl!
    @IBOutlet private weak var thoughtTxt: UITextView!
    @IBOutlet private weak var postBtn: UIButton!
    
    // Variables
    private var selectedCategory = ThoughtCategory.funny.rawValue
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // gives button and textview more rounded corners
        postBtn.layer.cornerRadius = 4
        thoughtTxt.layer.cornerRadius = 4
        
        // making a placeholder for TextView
        thoughtTxt.text = "My random thought..."
        thoughtTxt.textColor = UIColor.lightGray
        thoughtTxt.delegate = self
    }
    
    // when user tries to edit textview, remove placeholder text
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        textView.textColor = UIColor.darkGray
    }
    
    @IBAction func postBtnTapped(_ sender: Any) {
        // create document in the "thoughts" collection
        Firestore.firestore().collection(THOUGHTS_REF).addDocument(data: [
            CATEGORY : selectedCategory,
            NUM_COMMENTS : 0,
            NUM_LIKES : 0,
            THOUGHT_TXT : thoughtTxt.text,
            TIMESTAMP : FieldValue.serverTimestamp(),
            USERNAME : Auth.auth().currentUser?.displayName ?? "",
            USER_ID : Auth.auth().currentUser?.uid ?? ""
        ]) { (err) in
            if let err = err {
                debugPrint("Error: \(err)")
            } else {
                // go back to previous view controller
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @IBAction func categoryChanged(_ sender: Any) {
        switch categorySegment.selectedSegmentIndex {
        case 0:
            selectedCategory = ThoughtCategory.funny.rawValue
        case 1:
            selectedCategory = ThoughtCategory.serious.rawValue
        default:
            selectedCategory = ThoughtCategory.crazy.rawValue
        }
    }
}
