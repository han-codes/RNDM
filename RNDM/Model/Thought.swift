//
//  Thought.swift
//  RNDM
//
//  Created by Hannie Kim on 12/12/18.
//  Copyright © 2018 Hannie Kim. All rights reserved.
//

import Foundation

class Thought {
    
    // can read the var anywhere, but an only set value in this class
    private(set) var username: String!
    private(set) var timestamp: Date!
    private(set) var thoughtTxt: String!
    private(set) var numLikes: Int!
    private(set) var numComments: Int!
    private(set) var documentId: String!
    
    init(username: String, timestamp: Date, thoughtTxt: String, numLikes: Int, numComments: Int, documentId: String) {
        self.username = username
        self.timestamp = timestamp
        self.thoughtTxt = thoughtTxt
        self.numLikes = numLikes
        self.numComments = numComments
        self.documentId = documentId
    }
    
}
