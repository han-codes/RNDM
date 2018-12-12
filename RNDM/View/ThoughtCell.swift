//
//  ThoughtCell.swift
//  RNDM
//
//  Created by Hannie Kim on 12/12/18.
//  Copyright © 2018 Hannie Kim. All rights reserved.
//

import UIKit

class ThoughtCell: UITableViewCell {

    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var timestampLbl: UILabel!
    @IBOutlet weak var thoughtTxtLbl: UILabel!
    @IBOutlet weak var likesImg: UIImageView!
    @IBOutlet weak var likesNumLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureCell(thought: Thought) {
        usernameLbl.text = thought.username
        thoughtTxtLbl.text = thought.thoughtTxt
        likesNumLbl.text = String(thought.numLikes)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, hh:mm"
        let timestamp = formatter.string(from: thought.timestamp)
        
        timestampLbl.text = timestamp
        
        // likesImg.image = UIImage(named: <#T##String#>)
    }
}
