//
//  NewResisterVC.swift
//  NoNa_App
//
//  Created by Lee Janghyup on 9/18/15.
//  Copyright © 2015 jay. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class NewResisterVC: UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {

    var logInViewController : PFLogInViewController = PFLogInViewController()
    var signUpViewController : PFSignUpViewController = PFSignUpViewController()
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()

        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if (PFUser.currentUser() == nil) {
            
            self.logInViewController.fields = [PFLogInFields.UsernameAndPassword,
                PFLogInFields.LogInButton, PFLogInFields.SignUpButton,
                PFLogInFields.PasswordForgotten, PFLogInFields.DismissButton]
            
            let loginLogoTitle = UILabel()
            loginLogoTitle.text = "bany"
            
            self.logInViewController.logInView!.logo = loginLogoTitle
            
            self.logInViewController.delegate = self
            
            let signUpLogoTitle = UILabel()
            signUpLogoTitle.text = "bany"
            
            self.signUpViewController.signUpView!.logo = signUpLogoTitle
            
            self.signUpViewController.delegate = self
            
            self.logInViewController.signUpController = self.signUpViewController
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Parse Login
    
    func logInViewController(logInController: PFLogInViewController, shouldBeginLogInWithUsername username: String, password: String) -> Bool {
     
        if(!username.isEmpty || !password.isEmpty) {
            return true
        }else{
            return false
        }
        
    }
    
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func logInViewController(logInController: PFLogInViewController, didFailToLogInWithError error: NSError?) {
        print("Fail to login")
    }
    
    
  
    //MARK: Parse Sign Up
    
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func signUpViewController(signUpController: PFSignUpViewController, didFailToSignUpWithError error: NSError?) {
        print("fail to sign up...")
    }
    
    func signUpViewControllerDidCancelSignUp(signUpController: PFSignUpViewController) {
        print("User dismissed sign up")
    }
    
    // mark: Actions
    
    @IBAction func simpleAction(send: AnyObject) {
        
        self.presentViewController(self.logInViewController, animated: true, completion: nil)
    }
    
    func logOutAction(sender: AnyObject) {
        
        PFUser.logOut()
    }
    
}
