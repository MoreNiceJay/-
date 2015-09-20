//
//  CommentData.swift
//  NoNa_App
//
//  Created by Lee Janghyup on 9/12/15.
//  Copyright (c) 2015 jay. All rights reserved.
//

import Foundation
import Parse
struct Comment {
    var comment : String?
    var user = PFUser.currentUser()
}

struct myParse {
    var post = PFObject(className: "Posts")
    var myComment = PFObject(className:"Comment")
}

func dismissKeboard(textField : UITextField, shouldchangeTextInRange range : NSRange, replacementText text : String) -> Bool{
    
    if text == "\n" {
       // passwordTextField.resignFirstResponder()
       // usernameTextField.resignFirstResponder()
       // emailTextField.resignFirstResponder()
        return true
    }else {
        return false
            }
        
}

