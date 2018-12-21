//
//  CommentsVC.swift
//  RNDM
//
//  Created by Hannie Kim on 12/21/18.
//  Copyright © 2018 Hannie Kim. All rights reserved.
//

import UIKit

class CommentsVC: UIViewController {

    // Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addCommentTxt: UITextField!
    @IBOutlet weak var keyboardView: UIView!
    
    // Variables
    var thought: Thought!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func addCommentTapped(_ sender: Any) {
        
    }
}
