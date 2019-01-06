//
//  CommentCell.swift
//  RNDM
//
//  Created by Hannie Kim on 12/21/18.
//  Copyright © 2018 Hannie Kim. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {
    @IBOutlet weak var usernameTxt: UILabel!
    @IBOutlet weak var timestampTxt: UILabel!
    @IBOutlet weak var commentTxt: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureCell(comment: Comment) {
        usernameTxt.text = comment.username
        
        // formats date then makes it a string
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, hh:mm"
        let timestamp = formatter.string(from: comment.timestamp)
        
        timestampTxt.text = timestamp
        
        commentTxt.text = comment.commentTxt
    }

}
