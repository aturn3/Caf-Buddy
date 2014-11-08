//
//  LogInViewController.swift
//  CafMate
//
//  Created by Jacob Forster on 11/8/14.
//  Copyright (c) 2014 St. Olaf ACM. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        createLayout()
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