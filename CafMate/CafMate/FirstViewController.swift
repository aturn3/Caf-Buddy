//
//  FirstViewController.swift
//  CafMate
//
//  Created by Jacob Forster on 11/8/14.
//  Copyright (c) 2014 St. Olaf ACM. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    var mainTableView = UITableView()
    
    var meals: [String] = ["Breakfast", "Lunch", "Dinner"]
    
    var ifMatched = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainTableView.registerClass(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
        initInterface()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func initInterface() {
        var screenWidth = Float(self.view.frame.size.width)
        var screenHeight = Float(self.view.frame.size.height)
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
        mainTableView.frame = CGRectMake(0,20, CGFloat(screenWidth),CGFloat(screenHeight-69))
        
        self.view.addSubview(mainTableView)
        
        
        mainTableView.rowHeight = (self.view.frame.size.height-69)/3
        
        updateInterface()
    }
    
    func updateInterface() {
        
        
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var customcell:CustomTableViewCell = tableView.dequeueReusableCellWithIdentifier("cell") as CustomTableViewCell
        
        //var cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as CustomTableViewCell
        
        //customcell.whichMeal.text = self.meals[indexPath.row]
        
        //customcell.loadItem("test test s df s dfsdf")
        
        if (ifMatched==true) {
            
            customcell.loadItem("\(self.meals[indexPath.row])",rangeOfTIme: "",timeOfMeal: "5:00 PM",matching: "Match Found")
            
            
        } else {
            
            customcell.loadItem("\(self.meals[indexPath.row])",rangeOfTIme: "3:30 - 4:00 PM",timeOfMeal: "",matching: "Finding a Match")
            
        }
        
        return customcell
    }

}

