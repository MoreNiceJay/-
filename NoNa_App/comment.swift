//
//  comment.swift
//  NoNa_App
//
//  Created by Lee Janghyup on 9/12/15.
//  Copyright (c) 2015 jay. All rights reserved.
//

import UIKit
import Parse

class comment: UIViewController, UITableViewDelegate {
    @IBOutlet weak var tableViewComment: UITableView!
    @IBOutlet weak var textFieldComment: UITextField!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    var commentArray = [String]()
    var parentObjectID = String()
    var userIdArray = [String]()
    
    @IBAction func uploadComment(sender: AnyObject) {
      
        activityIndicatorOn()
        
        let comment = PFObject(className:"Comment")
        
        comment["createdBy"] = PFUser.currentUser()
        comment["comment"] = "" + textFieldComment.text!
        comment["parent"] = parentObjectID
        comment["username"] = PFUser.currentUser()?.username
        
        comment.saveInBackgroundWithBlock { (success : Bool, error : NSError?) -> Void in
            if error == nil {
                
               self.commentArray = []
                self.queryComment()
                self.textFieldComment.text = ""
                
            }else { print(error)
            }
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        queryComment()
        
         }
    
    func queryComment() {
        activityIndicatorOn()
        
        let queryComments = PFQuery(className: "Comment")
        
        queryComments.whereKey("parent", equalTo: "\(parentObjectID)")
        queryComments.orderByAscending("createdAt")
        queryComments.findObjectsInBackgroundWithBlock {
            (comments: [AnyObject]?, error: NSError?) -> Void in
           
            // comments now contains the comments for myPost
            
            if error == nil {
                //에러없는 경우
                for post in comments! {
                    self.commentArray.append(post["comment"] as! String)
                    self.userIdArray.append(post["username"] as! String)
                   
                }
                }else{
                print(error)
            }
            self.tableViewComment.reloadData()
            self.activityIndicatorOff()
        }
    }
    
    func activityIndicatorOn() {
        loading.hidden = false
        loading.startAnimating()
    }
    func activityIndicatorOff() {
        self.loading.hidden = true
        self.loading.stopAnimating()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return commentArray.count
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell1", forIndexPath: indexPath) 
       
        cell.textLabel?.text = self.commentArray[indexPath.row]
        cell.detailTextLabel!.text = "Id:" + self.userIdArray[indexPath.row]
        
        return cell
    }
}
