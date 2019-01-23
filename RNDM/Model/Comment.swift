//
//  Comment.swift
//  RNDM
//
//  Created by Hannie Kim on 1/2/19.
//  Copyright © 2019 Hannie Kim. All rights reserved.
//

import Foundation
import Firebase

class Comment {
    // can read the var anywhere, but an only set value in this class
    private(set) var username: String!
    private(set) var timestamp: Date!
    private(set) var commentTxt: String!
    private(set) var documentId: String!
    private(set) var userId: String!
    
    init(username: String, timestamp: Date, commentTxt: String, documentId: String, userId: String) {
        self.username = username
        self.timestamp = timestamp
        self.commentTxt = commentTxt
        self.documentId = documentId
        self.userId = userId
    }

    // method to parse Firestore data to [Comment]() array from a snapshot
    class func parseData(snapshot: QuerySnapshot?) -> [Comment] {
        var comments = [Comment]()
        
        // if there is not a snapshot, then just return and empty Comment array
        guard let snap = snapshot else { return comments }
        
        // loop through all the documents for the snapshot collection
        for document in snap.documents {
            let data = document.data()
            let username = data[USERNAME] as? String ?? "Anonymous"
            let timestamp = data[TIMESTAMP] as? Date ?? Date()
            let commentTxt = data[COMMENT_TXT] as? String ?? ""
            let documentId = document.documentID
            let userId = data[USER_ID] as? String ?? ""
            
            // create new objects with the field values from the snapshot passed
            // this will add all the comment docuents 
            let newComment = Comment(username: username, timestamp: timestamp, commentTxt: commentTxt, documentId: documentId, userId: userId)
            comments.append(newComment)
        }
        // return the array of Comment objects
        return comments
    }
}
