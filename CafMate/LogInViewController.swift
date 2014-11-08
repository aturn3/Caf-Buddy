//
//  LogInViewController.swift
//  CafMate
//
//  Created by Jacob Forster on 11/8/14.
//  Copyright (c) 2014 St. Olaf ACM. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController,PFLogInViewControllerDelegate,PFSignUpViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        createLayout()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let logInViewController:PFLogInViewController = PFLogInViewController()
        logInViewController.delegate = self
        
        let signUpViewController = PFSignUpViewController()
        signUpViewController.delegate = self
        
        logInViewController.signUpController = signUpViewController
        presentViewController(logInViewController, animated: true, completion: nil)
        
    }
    
    func logInViewController(logInController: PFLogInViewController!, shouldBeginLogInWithUsername username: String!, password: String!) -> Bool {
        
        if ((username != nil) && (password != nil) && (countElements(username) != 0) && (countElements(password) != 0))
        {
            return true
        }
            
        let alert = UIAlertView()
        alert.title = "Missing Information"
        alert.message = "Make Sure You Fill Out All Your Information"
        alert.show()
        return false
    }
    
    func logInViewController(logInController: PFLogInViewController!, didLogInUser user: PFUser!) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func logInViewController(logInController: PFLogInViewController!, didFailToLogInWithError error: NSError!) {
        println("Failed to Log In")
    }
    
    func logInViewControllerDidCancelLogIn(logInController: PFLogInViewController!) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createLayout() {
        var gameScore = PFObject(className: "GameScore")
        gameScore.setObject(1337, forKey: "score")
        gameScore.setObject("Sean Plott", forKey: "playerName")
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