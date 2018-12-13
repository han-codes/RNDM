//
//  Thought.swift
//  RNDM
//
//  Created by Hannie Kim on 12/12/18.
//  Copyright © 2018 Hannie Kim. All rights reserved.
//

import Foundation
import Firebase

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
    
    // method to parse Firestore data to array, that table view will display
    class func parseData(snapshot: QuerySnapshot?) -> [Thought]{
        var thoughts = [Thought]()
        
        guard let snap = snapshot else { return thoughts }
        for document in snap.documents {
            let data = document.data()
            let username = data[USERNAME] as? String ?? "Anonymous"
            let timestamp = data[TIMESTAMP] as? Date ?? Date()
            let thoughtTxt = data[THOUGHT_TXT] as? String ?? ""
            let numLikes = data[NUM_LIKES] as? Int ?? 0
            let numComments = data[NUM_COMMENTS] as? Int ?? 0
            let documentId = document.documentID
            
            // add objects with fetched data into thought sarray
            let newThought = Thought(username: username, timestamp: timestamp, thoughtTxt: thoughtTxt, numLikes: numLikes, numComments: numComments, documentId: documentId)
            thoughts.append(newThought)
        }
        
        return thoughts
    }
}
