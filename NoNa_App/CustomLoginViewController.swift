//
//  CustomLoginViewController.swift
//  NoNa_App
//
//  Created by Lee Janghyup on 9/18/15.
//  Copyright © 2015 jay. All rights reserved.
//

import UIKit
import Parse
class CustomLoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var actInd : UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    self.actInd.center = self.view.center
        self.actInd.hidesWhenStopped = true
        self.actInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        
        view.addSubview(self.actInd)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginAction(sender: AnyObject) {
        
        let username = self.usernameField.text
        let password = self.passwordField.text
        
        if (username?.utf16.count < 4 || password?.utf16.count < 5) {
            let alert = UIAlertView(title: "Invalid", message: "Username must be greater then 4 and Password must be a greater then 5.", delegate: self, cancelButtonTitle: "OK")
            
            alert.show()
        } else {
            self.actInd.startAnimating()
            
            PFUser.logInWithUsernameInBackground(username!, password: password!, block: { (user, error) -> Void in
                self.actInd.stopAnimating()
                
                if((user) != nil) {
                    
                    let alert = UIAlertView(title: "Success", message: "Logged In", delegate: self, cancelButtonTitle: "OK")
                    
                    alert.show()
                    
                }else {
                    let alert = UIAlertView(title: "Error", message: "\(error)", delegate: self, cancelButtonTitle: "OK")
                    
                    alert.show()
                    
                }
                
            })
            
            
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
