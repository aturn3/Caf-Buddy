//
//  SecondViewController.swift
//  CafMate
//
//  Created by Jacob Forster on 11/8/14.
//  Copyright (c) 2014 St. Olaf ACM. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UIPickerViewDataSource,UIPickerViewDelegate {
    
    let statusBarHeight = 20;
    
    let mealTypesArr = ["Breakfast","Lunch","Dinner"]
    let mealStartEndTimes = [["7:00","10:15"],["10:30","14:00"],["16:30","19:30"]]
    
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    var mealTypeLabel = UILabel()
    var mealTypeTextField = UITextField()
    var mealTypePickerView = UIPickerView()
    
    var mealTimeLabel = UILabel()
    var mealTimeTextField = UITextField()
    var mealTimePickerView = UIPickerView()
    
    var buttonCreateMeal = UIButton()
    
    var timeRange = NSMutableArray()
    var chosenStartTime = NSDate()
    var chosenEndTime = NSDate()
    var chosenMealType = -1
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        initInterface();
        getPickerOptions(0)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func initInterface() {
        var labelWidth = 325;
        
        self.view.backgroundColor = colorWithHexString(COLOR_MAIN_BACKGROUND_OFFWHITE)
        
        mealTypeLabel.text = "What meal do you want a buddy at?"
        mealTypeLabel.font = UIFont.systemFontOfSize(20)
        mealTypeLabel.frame = CGRectMake((screenSize.width - CGFloat(labelWidth))/2, CGFloat(statusBarHeight + 20), CGFloat(labelWidth), 30)
        mealTypeLabel.textAlignment = NSTextAlignment.Center
        
        mealTypePickerView.delegate = self
        mealTypePickerView.dataSource = self
        
        mealTypeTextField.frame = CGRectMake(150/2, mealTypeLabel.frame.origin.y + 35, (screenSize.width - 150), 50)
        mealTypeTextField.backgroundColor = UIColor.whiteColor()
        mealTypeTextField.inputView = mealTypePickerView
        mealTypeTextField.layer.cornerRadius = 3.0
        mealTypeTextField.font = UIFont.systemFontOfSize(20)
        mealTypeTextField.textAlignment = NSTextAlignment.Center
        mealTypeTextField.placeholder = "Choose A Meal"
        
        
        mealTimeLabel.text = "When are you available?"
        mealTimeLabel.font = UIFont.systemFontOfSize(20)
        mealTimeLabel.frame = CGRectMake((screenSize.width - CGFloat(labelWidth))/2, CGFloat(mealTypeTextField.frame.size.height + mealTypeTextField.frame.origin.y + 60), CGFloat(labelWidth), 30)
        mealTimeLabel.textAlignment = NSTextAlignment.Center
        
        mealTimePickerView.delegate = self
        mealTimePickerView.dataSource = self
        
        mealTimeTextField.frame = CGRectMake(150/2, mealTimeLabel.frame.origin.y + 35, (screenSize.width - 150), 50)
        mealTimeTextField.backgroundColor = UIColor.whiteColor()
        mealTimeTextField.inputView = mealTimePickerView
        mealTimeTextField.layer.cornerRadius = 3.0
        mealTimeTextField.font = UIFont.systemFontOfSize(20)
        mealTimeTextField.textAlignment = NSTextAlignment.Center
        mealTimeTextField.placeholder = "Choose A Time Range"
        
        buttonCreateMeal.titleForState(UIControlState.Normal)
        buttonCreateMeal.setTitle("Find Me A Buddy", forState: UIControlState.Normal)
        buttonCreateMeal.frame = CGRectMake(50, mealTimeTextField.frame.size.height + mealTimeTextField.frame.origin.y + 70, screenSize.width - 100, 60)
        buttonCreateMeal.backgroundColor = UIColor.blueColor()
        buttonCreateMeal.layer.cornerRadius = 3.0
        buttonCreateMeal.addTarget(self, action: "sendMealToServer:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(mealTypeLabel)
        self.view.addSubview(mealTypeTextField)
        self.view.addSubview(mealTimeLabel)
        self.view.addSubview(mealTimeTextField)
        self.view.addSubview(buttonCreateMeal)
        
        updateInterface()
    }
    
    func updateInterface() {
        
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        if (pickerView == mealTypePickerView) {
            return 1
        }
        return 2;
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView == mealTypePickerView) {
            return 3
        }
        return timeRange.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        if (pickerView == mealTypePickerView) {
            return mealTypesArr[row]
        }
        let time = timeRange[row] as? NSString
        return time
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView == mealTypePickerView) {
            chosenMealType = row
            mealTypeTextField.text = mealTypesArr[row]
            timeRange = getPickerOptions(row)
            mealTimePickerView.reloadAllComponents()
        }
        else {
            let time = timeRange[row] as? NSString
            var stringLength = countElements(time as String)
            var stringVersion = time as String
            stringVersion = stringVersion.substringToIndex(advance(stringVersion.startIndex, stringLength-3))
            var theTime = getCurDateTime(stringVersion)
            
            if (component == 0) {
                chosenStartTime = theTime
            }
            else {
                chosenEndTime = theTime
            }
            displayTimeRange()
        }
        
        
    }
    
    func displayTimeRange() {
        var formatter = NSDateFormatter()
        formatter.dateFormat = "HH:mm a"
        
        var theString = "\(formatter.stringFromDate(chosenStartTime)) - \(formatter.stringFromDate(chosenEndTime))"
        mealTimeTextField.text = theString
        
    }
    
    func getPickerOptions(mealType: Int) -> NSMutableArray {
        var timeOptions = NSMutableArray()
        
        //var stringLength = countElements(mealStartEndTimes[mealType][0])
        var stringStart = mealStartEndTimes[mealType][0]
        //stringStart = stringStart.substringToIndex(advance(stringStart.startIndex, stringLength-3))
        var startTime = getCurDateTime(stringStart)
        NSLog(startTime.description)
        
        //stringLength = countElements(mealStartEndTimes[mealType][1])
        var stringEnd = mealStartEndTimes[mealType][1]
        //stringEnd = stringEnd.substringToIndex(advance(stringEnd.startIndex, stringLength-3))
        var endTime = getCurDateTime(stringEnd)
        NSLog(endTime.description)
        
        var formatter = NSDateFormatter()
        formatter.dateFormat = "HH:mm a"
        
        var nextTime = startTime
        for nextTime ; nextTime.compare(endTime) == NSComparisonResult.OrderedAscending ; nextTime = nextTime.dateByAddingTimeInterval(15*60) {
            timeOptions.addObject(formatter.stringFromDate(nextTime))
        }
        return timeOptions
    }
    
    func getCurDateTime(theTime: String) -> NSDate {
        var now = NSDate()
        var calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)
        var timeArr = theTime.componentsSeparatedByString(":")
        NSLog(timeArr[0])
        var components = calendar?.components(NSCalendarUnit.YearCalendarUnit | NSCalendarUnit.MonthCalendarUnit | NSCalendarUnit.DayCalendarUnit, fromDate: now)
        components?.hour = timeArr[0].toInt()!
        components?.minute = timeArr[1].toInt()!
        var curDate = calendar?.dateFromComponents(components!)
        return curDate!
        
    }
    
    func sendMealToServer(sender:UIButton!) {
        var theMeal = PFObject(className:"Meals")
        theMeal["matched"] = false
        theMeal["start"] = chosenStartTime
        theMeal["end"] = chosenEndTime
        theMeal["type"] = chosenMealType
        theMeal["userId"] = PFUser.currentUser()
        theMeal.saveInBackgroundWithBlock {
            
            (success: Bool!, error: NSError!) -> Void in
            
            if (success != nil) {
                
                NSLog("Object created with id: \(theMeal.objectId)")
                
            } else {
                
                NSLog("%@", error)
                
            }
            
        }
        
    }
    
    
}

