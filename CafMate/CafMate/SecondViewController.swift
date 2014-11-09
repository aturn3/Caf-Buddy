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
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

