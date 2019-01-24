//
//  CommentsVC.swift
//  RNDM
//
//  Created by Hannie Kim on 12/21/18.
//  Copyright © 2018 Hannie Kim. All rights reserved.
//

import UIKit
import Firebase

class CommentsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CommentDelegate {
    
    // Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addCommentTxt: UITextField!
    @IBOutlet weak var keyboardView: UIView!
    
    // Variables
    var thought: Thought!       // the thought from MainVC prepare(for segue:)
    var comments = [Comment]()
    var thoughtRef: DocumentReference!
    let firestore = Firestore.firestore()
    var username: String!
    var commentListener: ListenerRegistration!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        print(thought.thoughtTxt)
        
        thoughtRef = firestore.collection(THOUGHTS_REF).document(thought.documentId)
        
        // access username from CreateUserVC when we gave our displayName a username
        // this let us access the username if we needed it
        if let name = Auth.auth().currentUser?.displayName {
            username = name
        }
        
        self.view.bindToKeyboard()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // listens for changes in the comments document to display the correct ones in the tableView
        commentListener = firestore.collection(THOUGHTS_REF).document(self.thought.documentId)
            .collection(COMMENTS_REF)
            .order(by: TIMESTAMP, descending: false)
            .addSnapshotListener({ (snapshot, error) in
            // if snapshot doesn't exist, there's an error
            guard let snapshot = snapshot else {
                debugPrint("Error fetching comments: \(error!)")
                return
            }
            
            self.comments.removeAll()       // empty the comments array
            self.comments = Comment.parseData(snapshot: snapshot)   // loads all comments from snapshot listener
            self.tableView.reloadData()     // reload tableView so it displays the updated comments
        })
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        // remove the listener so it doesn't give issues to other listeners
        commentListener.remove()
    }
    
    // MARK: CommentDelegate Delegate Method
    func commentOptionsTapped(comment: Comment) {
        let alert = UIAlertController(title: "Edit Comment", message: "You can delete or edit", preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete Comment", style: .default) { (action) in
            
            // read thought, decrement 1 to the NUM_COMMENTS, delete the current comment document
            self.firestore.runTransaction({ (transaction, errorPointer) ->  Any? in
                let thoughtDocument: DocumentSnapshot
                
                do {
                    try thoughtDocument = transaction.getDocument(self.firestore.collection(THOUGHTS_REF).document(self.thought.documentId))
                } catch let error as NSError {
                    debugPrint("Fetch error: \(error.localizedDescription)")
                    return nil
                }
                
                guard let oldNumComments = thoughtDocument.data()![NUM_COMMENTS] as? Int else { return nil }
                
                transaction.updateData([NUM_COMMENTS : oldNumComments - 1], forDocument: self.thoughtRef)

                let commentRef = self.firestore.collection(THOUGHTS_REF).document(self.thought.documentId).collection(COMMENTS_REF).document(comment.documentId)
                transaction.deleteDocument(commentRef)

                return nil
            }) { (object, error) in
                if let error = error {
                    debugPrint("Transaction failed: \(error)")
                } else {
                    alert.dismiss(animated: true, completion: nil)
                }
            }
        }
        
        let editAction = UIAlertAction(title: "Edit Comment", style: .default) { (action) in
            // sends current comment and thought to UpdateCommentVC
            self.performSegue(withIdentifier: TO_UPDATE_COMMENT, sender: (comment, self.thought))
            alert.dismiss(animated: true, completion: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(deleteAction)
        alert.addAction(editAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? UpdateCommentVC {
            if let commentData = sender as? (comment: Comment, thought: Thought) {
                destination.commentData = commentData
            }
        }
    }
    
    @IBAction func addCommentTapped(_ sender: Any) {
        // getting the text that user entered
        guard let commentTxt = addCommentTxt.text else { return }
        
        firestore.runTransaction({ (transaction, errorPointer) ->  Any? in
            let thoughtDocument: DocumentSnapshot
            
            // getDocument throws so wrap with do try catch
            do {
                // get the document from the collection we need and set it to a DocumentSnapshot
                try thoughtDocument = transaction.getDocument(self.firestore.collection(THOUGHTS_REF).document(self.thought.documentId))
            } catch let error as NSError {
                debugPrint("Fetch error: \(error.localizedDescription)")
                return nil
            }
            
            // get the # of comments from thoughtDocument
            guard let oldNumComments = thoughtDocument.data()![NUM_COMMENTS] as? Int else { return nil }
            
            // update and add 1 to the number of comments
            transaction.updateData([NUM_COMMENTS : oldNumComments + 1], forDocument: self.thoughtRef)
            
            // create a new document
            let newCommentsRef = self.firestore.collection(THOUGHTS_REF).document(self.thought.documentId).collection(COMMENTS_REF).document()
            
            // set data to the new document's fields
            transaction.setData([
                COMMENT_TXT : commentTxt,
                TIMESTAMP : FieldValue.serverTimestamp(),
                USERNAME : self.username,
                USER_ID : Auth.auth().currentUser?.uid ?? ""
                ], forDocument: newCommentsRef)
            
            return nil
        }) { (object, error) in
            if let error = error {
                debugPrint("Transaction failed: \(error)")
            } else {
                // if transaction was successful, clear out the addCommentTxt label for the user to add another comment
                self.addCommentTxt.text = ""
                self.addCommentTxt.resignFirstResponder()       // resign the keyboard from UITextfield when user taps to add button
            }
        }
    }
    
    // TableView Delegate Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as? CommentCell {
            cell.configureCell(comment: comments[indexPath.row], delegate: self)
            
            return cell
        }
        
        return UITableViewCell()
        
    }
}
