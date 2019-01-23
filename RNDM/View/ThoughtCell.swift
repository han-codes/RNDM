//
//  ThoughtCell.swift
//  RNDM
//
//  Created by Hannie Kim on 12/12/18.
//  Copyright © 2018 Hannie Kim. All rights reserved.
//

import UIKit
import Firebase

class ThoughtCell: UITableViewCell {
    
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var timestampLbl: UILabel!
    @IBOutlet weak var thoughtTxtLbl: UILabel!
    @IBOutlet weak var likesImg: UIImageView!
    @IBOutlet weak var likesNumLbl: UILabel!
    @IBOutlet weak var commentsNumLbl: UILabel!
    @IBOutlet weak var optionsMenu: UIImageView!
    
    // Variables
    private var thought: Thought!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(likeTapped))
        likesImg.addGestureRecognizer(tap)
        likesImg.isUserInteractionEnabled = true
        
    }
    
    // increase number of likes in likesNumLbl when likesImg is tapped
    @objc func likeTapped() {
            Firestore.firestore().collection(THOUGHTS_REF).document(thought.documentId).setData([NUM_LIKES : thought.numLikes + 1], merge: true) { (error) in
                if let error = error {
                    debugPrint("Could not set new value for number of likes: \(error)")
                } else {
                    print("Adding number of likes successful")
                }
            }
    }
    
    func configureCell(thought: Thought) {
        // set ThoughtCell "thought" variable to equal the thought that's passed in from MainVC
        // this way we can access its documentId and numLikes for @objc func likeTapped()
        self.thought = thought
        
        usernameLbl.text = thought.username
        thoughtTxtLbl.text = thought.thoughtTxt
        likesNumLbl.text = String(thought.numLikes)
        commentsNumLbl.text = String(thought.numComments)
        
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, hh:mm"
        let timestamp = formatter.string(from: thought.timestamp)
        
        timestampLbl.text = timestamp
    }
}
