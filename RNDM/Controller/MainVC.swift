//
//  ViewController.swift
//  RNDM
//
//  Created by Hannie Kim on 11/14/18.
//  Copyright © 2018 Hannie Kim. All rights reserved.
//

import UIKit

enum ThoughtCategory: String {
    case funny = "funny"
    case serious = "serious"
    case crazy = "crazy"
    case popular = "popular"
    
}

class MainVC: UIViewController {

    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}

