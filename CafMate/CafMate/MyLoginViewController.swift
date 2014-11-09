//
//  MyLoginViewController.swift
//  CafMate
//
//  Created by Joseph Peterson on 11/8/14.
//  Copyright (c) 2014 St. Olaf ACM. All rights reserved.
//

import UIKit

class MyLoginViewController : PFLogInViewController
{
    override func viewDidLoad() {
        super.viewDidLoad()
        let label = UILabel()
        label.text = "Caf Buddy"
        label.font = UIFont(name: label.font.fontName, size: 55)
        label.sizeToFit()
        self.logInView.logo = label
        
    }
}