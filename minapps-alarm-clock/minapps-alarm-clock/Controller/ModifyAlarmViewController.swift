//
//  ModifyAlarmViewController.swift
//  minapps-alarm-clock
//
//  Created by Jibran Syed on 12/13/17.
//  Copyright © 2017 Jishenaz. All rights reserved.
//

import UIKit
import CoreData

class ModifyAlarmViewController: UIViewController 
{
    static let STRYBRD_ID = "ModifyAlarmVC"
    
    private var alarm: AlarmEntity_CoreData!
    
    override func viewDidLoad() 
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
    
    
    func loadAlarm(_ passedAlarm: AlarmEntity_CoreData)
    {
        self.alarm = passedAlarm
    }
    
    
}
