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
    
    var numMeals = 0
    
    var meals: [String] = []
    
    var ifMatched: [Bool] = []
    
    var startTime: [String] = []
    
    var endTime: [String] = []
    
    var matchString: [String] = []
    
    var mealTimeRange: [String] = []
    
    var breakfast = "Breakfast"
    
    var lunch = "Lunch"
    
    var dinner = "Dinner"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        PFCloud.callFunctionInBackground("test", withParameters:[:]) {
            (result: AnyObject!, error: NSError!) -> Void in
            if error == nil {
                println("result")
            }
        }
        self.mainTableView.registerClass(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
        var userObjectID = PFUser.currentUser().objectId
        //println(userObjectID)
        println("Something should print")
        PFCloud.callFunctionInBackground("getMealsToday", withParameters:["objectID":userObjectID]) {
            (result: AnyObject!, error: NSError!) -> Void in
            if error == nil {
                println("Something should print")
                println(result)
                //var test = "{\"firstName\":\"John\", \"lastName\":\"Doe\"}"
                let testData = (result as NSString).dataUsingEncoding(NSUTF8StringEncoding)
                let jsonObject = JSON(data: testData!, options: nil, error: nil)
                //println(jsonObject[0]["createdAt"].stringValue)
                for (var i=0;i<jsonObject.count;i++)
                {
                    self.numMeals = jsonObject.count
                    var meal = jsonObject[i]["type"].stringValue
                    if meal=="0" {
                        self.meals.append(self.breakfast)
                    } else if meal=="1" {
                        self.meals.append(self.lunch)
                    } else if meal=="2" {
                        self.meals.append(self.dinner)
                    }
                    
                    if !(jsonObject[i]["matched"].stringValue=="true") {
                        self.ifMatched.append(false)
                        var sTime = jsonObject[i]["start"]["iso"].stringValue
                        var formatterS = NSDateFormatter()
                        formatterS.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                        var dateS = formatterS.dateFromString(sTime)
                        formatterS.dateFormat = "HH:mm"
                        var localSTime = formatterS.stringFromDate(dateS!)
                        self.startTime.append(localSTime)
                        var eTime = jsonObject[i]["end"]["iso"].stringValue
                        var formatterE = NSDateFormatter()
                        formatterE.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                        var dateE = formatterE.dateFromString(eTime)
                        formatterE.dateFormat = "HH:mm"
                        var localETime = formatterE.stringFromDate(dateE!)
                        self.endTime.append(localETime)
                        self.matchString.append("Finding Match")
                        self.mealTimeRange.append(self.startTime[i] + String("-") + self.endTime[i])
                        
                        
                    }
                    
                    else {
                        var sTime = jsonObject[i]["start"]["iso"].stringValue
                        var formatterS = NSDateFormatter()
                        formatterS.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                        var dateS = formatterS.dateFromString(sTime)
                        formatterS.dateFormat = "HH:mm"
                        var localSTime = formatterS.stringFromDate(dateS!)
                        self.startTime[i] = localSTime
                        self.endTime[i] = ""
                        self.ifMatched[i] = true
                        self.matchString[i] = "Match Found"
                    }
                    
                    //println(self.startTime)
                }
                
            }
            else{
                println("error")
            }
        }
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
        
        var floatNumMeals = Float(self.numMeals)
        var cellHeight = self.view.frame.size.height
        mainTableView.rowHeight = (cellHeight - 69)/3
        //mainTableView.rowHeight = CGFloat( cellheight - 69)/CGFloat(floatNumMeals)
        
        updateInterface()
    }
    
    func updateInterface() {
        
        
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
        //return self.numMeals
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var customcell:CustomTableViewCell = tableView.dequeueReusableCellWithIdentifier("cell") as CustomTableViewCell
        
        //var cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as CustomTableViewCell
        
        //customcell.whichMeal.text = self.meals[indexPath.row]
        
        //customcell.loadItem("test test s df s dfsdf")
        
//        println(self.meals.count)
        
        if (ifMatched[indexPath.row]==true) {
            
            customcell.loadItem("\(self.meals[indexPath.row])",rangeOfTIme: "",timeOfMeal: "\(self.startTime[indexPath.row])",matching: "\(self.matchString[indexPath.row])")
            
            
        } else {
            
            customcell.loadItem("\(self.meals[indexPath.row])",rangeOfTIme: "\(self.mealTimeRange[indexPath.row])",timeOfMeal: "",matching: "\(self.matchString[indexPath.row])")
            
        }
        
        return customcell
    }

}

