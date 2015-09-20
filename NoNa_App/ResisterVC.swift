//
//  ViewController.swift
//  NoNa_App
//
//  Created by Lee Janghyup on 8/26/15.
//  Copyright (c) 2015 jay. All rights reserved.
//

import UIKit
import Parse

class ResisterVC: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var confirmEmailTextField: UITextField!
    
    func dismissKeboard(textField : UITextField, shouldchangeTextInRange range : NSRange, replacementText text : String) -> Bool{
        
        if text == "\n" {
            passwordTextField.resignFirstResponder()
            usernameTextField.resignFirstResponder()
            emailTextField.resignFirstResponder()
            confirmEmailTextField.resignFirstResponder()
            return true
        }else {
            return false
            
        }
        
        
        
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        passwordTextField.resignFirstResponder()
        usernameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        confirmEmailTextField.resignFirstResponder()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
           }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func resisterButtonTapped(sender: AnyObject) {
        let username = usernameTextField.text
        let email = emailTextField.text
        let password = passwordTextField.text
        let confirmPassword = confirmEmailTextField.text
        
        if username!.isEmpty  || email!.isEmpty || password!.isEmpty ||   confirmPassword!.isEmpty {
            
            //유저에게 다시 시도하라고 알리기
            print("레지스터페이지 : 유저 빈칸 안채움")
            
             var alert = UIAlertController(title: "Oh miss something", message: "", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Let's fill it up", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
            
        }else {
            //패스워드 맞게 쳤는지 확인
            
            if password == confirmPassword {
            
            //가입허락하기
            
            
            let user = PFUser()
            
            user.username = username
            user.email = email
            user.password = password
            user.signUpInBackgroundWithBlock({ (isSuccesful : Bool, error :NSError?) -> Void in
                
                if error == nil {
                    
                    //가입시키기
                    
                    print(isSuccesful)
                    self.performSegueWithIdentifier("resisterToHome", sender: self)
                    
                    
                    
                }else {
                    //에러 경고창 띄우기
                    
                    var alert = UIAlertController(title: "Try again", message: "There is network problem", preferredStyle: .Alert)
                    alert.addAction(UIAlertAction(title: "Try again", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                    
                    print(error)
                    print("레지스터 : 가입프로세스 에러")
                }
                
            })
            
            }else {
                //패스워드가 맞지 않음
                var alert = UIAlertController(title: "Unmatched password", message: "", preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
                passwordTextField.text = ""
                confirmEmailTextField.text = ""
            }}
        

        

        
    }

}

