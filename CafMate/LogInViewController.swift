//
//  LogInViewController.swift
//  CafMate
//
//  Created by Jacob Forster on 11/8/14.
//  Copyright (c) 2014 St. Olaf ACM. All rights reserved.
//

import UIKit
extension String {
    subscript (r: Range<Int>) -> String {
        get {
            let startIndex = advance(self.startIndex, r.startIndex)
            let endIndex = advance(startIndex, r.endIndex - r.startIndex)
            
            return self[Range(start: startIndex, end: endIndex)]
        }
    }
}

class LogInViewController: UIViewController,PFLogInViewControllerDelegate,PFSignUpViewControllerDelegate {
    var LoggedIn = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //createLayout()
    }
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        if(!LoggedIn){
        let logInViewController:PFLogInViewController = PFLogInViewController()
        logInViewController.delegate = self
        let signUpViewController = PFSignUpViewController()
        signUpViewController.delegate = self
        

        logInViewController.signUpController = signUpViewController
        presentViewController(logInViewController, animated: true, completion: nil)
        }
    }
    
    
    
    func logInViewController(logInController: PFLogInViewController!, shouldBeginLogInWithUsername username: String!, password: String!) -> Bool {
 
        if ((username != nil) && (password != nil) && (countElements(username) != 0) && (countElements(password) != 0))
        {
            return true
        }
        
        let alert = UIAlertView()
        alert.title = "Missing Information"
        alert.message = "Make Sure You Fill Out All Your Information"
        alert.addButtonWithTitle("Cancel")
        alert.show()
        
        return false
    }
    
    
    
    func logInViewController(logInController: PFLogInViewController!, didLogInUser user: PFUser!) {
        
        dismissViewControllerAnimated(true, completion: nil)
        println("User Login Succesful")
        LoggedIn=true
    }
    
    
    
    func logInViewController(logInController: PFLogInViewController!, didFailToLogInWithError error: NSError!) {
        
        println("Failed to Log In")
        
    }
    
    
    
    func logInViewControllerDidCancelLogIn(logInController: PFLogInViewController!) {
        
        navigationController?.popViewControllerAnimated(true)
        
    }
    
    func signUpViewControllerDidCancelSignUp(signUpController: PFSignUpViewController!) {
        println("User Dismissed the Sign Up View Controller")
    }
    
    func signUpViewController(signUpController: PFSignUpViewController!, shouldBeginSignUp info: [NSObject : AnyObject]!) -> Bool {
        //println(info)
        var message = ""
        var isValid = true
        var emailEnd = ""
        for (key, value) in info {
            let fieldValue: AnyObject? = value
            println("Key is \(key) and values is \(value)")
            
            if key == "username"
            {
                
                var email = value as String
                let emailLength = countElements(email)
                
                if emailLength > 11
                {
                emailEnd = email[(emailLength-11)...(emailLength-1)]
                }
                else
                {
                    isValid = false
                    message = message+"Sorry Email too short."
                }
                
                if (email.rangeOfString("@") == nil)
                {
                    isValid = false
                    println("Email Invalid does not contain @ sign")
                    message = message+" Email does not contain @ sign."
                    break
                    
                }
                if (emailEnd != "@stolaf.edu" )
                {
                    isValid = false
                    println("Sorry we only except St Olaf Emails")
                    message = message+" Email Invalid, Sorry we only except St Olaf Emails."
                    break
                }
                
            }
            if ((fieldValue == nil) || fieldValue?.length == 0) { // check completion
                isValid = false;
                break;
            }
            
            if ((fieldValue == nil) || fieldValue?.length <= 8) { // check completion
                isValid = false;
                message = message+" Password needs to be longer than 8 characters."
                break;
            }
            
            
        }
       
        if(!isValid){
        let alert = UIAlertView()
        alert.title = "Error!"
        alert.message = message
        alert.addButtonWithTitle("Cancel")
        alert.show()
        }
        
        /*
            else if (countElements(self.signUpView.usernameField.text!) < 2) {
                NSLog("signup field text less than 2")
                // display alert
                informationComplete = false
            } else if (self.signUpView.passwordField) {
                NSLog("password error ")
                // display alert
                informationComplete = false
            }
        }*/
        return isValid
    }
    
    
    func signUpViewController(signUpController: PFSignUpViewController!, didSignUpUser user: PFUser!) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func signUpViewController(signUpController: PFSignUpViewController!, didFailToSignUpWithError error: NSError!) {
        println("Failed to sign up...")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func createLayout() {
        var gameScore = PFObject(className: "TestClass")
        gameScore.setObject(1337, forKey: "score")
        gameScore.setObject("Nooney Nooney", forKey: "playerName")
        
        gameScore.saveInBackgroundWithBlock {
            (success: Bool!, error: NSError!) -> Void in
            if (success != nil) {
                NSLog("Object created with id: \(gameScore.objectId)")
            } else {
                NSLog("%@", error)
            }
        }
        
        
        /*var screenwidth = Float(self.view.frame.size.width)
        var thewid = 200
        var final = screenwidth - Float(half)
        //var myTextField: UITextField = UITextField(frame: CGRect(x: screenwidth-thewid/2, y: 0, width: 200, height: 40.00))
        var myTextField = UITextField(frame: CGRectMake(CGFloat(final), 0, 200, 40.0))
        self.view.addSubview(myTextField)
        myTextField.backgroundColor = UIColor.redColor()
        myTextField.text = "some string"*/
    }
    
}