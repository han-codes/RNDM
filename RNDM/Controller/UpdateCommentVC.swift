//
//  UpdateCommentVC.swift
//  RNDM
//
//  Created by Hannie Kim on 1/24/19.
//  Copyright © 2019 Hannie Kim. All rights reserved.
//

import UIKit
import Firebase

class UpdateCommentVC: UIViewController {

    @IBOutlet weak var commentTxt: UITextView!
    @IBOutlet weak var updateBtn: UIButton!
    
    var commentData: (comment: Comment, thought: Thought)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentTxt.layer.cornerRadius = 10
        updateBtn.layer.cornerRadius = 10        
        commentTxt.text = commentData.comment.commentTxt
    }
    
    @IBAction func updateTapped(_ sender: Any) {
        Firestore.firestore().collection(THOUGHTS_REF).document(commentData.thought.documentId)
            .collection(COMMENTS_REF).document(commentData.comment.documentId)
            .updateData([COMMENT_TXT : commentTxt.text]) { (error) in
                if let error = error {
                    debugPrint("Error updating comment text \(error)")
                } else {
                    self.navigationController?.popViewController(animated: true)
                }
        }
    }
}
