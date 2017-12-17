//
//  RingingAlarmLaunchable.swift
//  minapps-alarm-clock
//
//  Created by Jibran Syed on 12/17/17.
//  Copyright © 2017 Jishenaz. All rights reserved.
//

import UIKit
import CoreData

// Anyone adapting this protocol must be able to launch an alarm
protocol RingingAlarmLaunchable: class
{
    func launchAlarm(_ alarm: AlarmEntity_CoreData)
}


// Implementation of RingingAlarmLaunchable specific to view controllers
extension RingingAlarmLaunchable where Self: UIViewController
{
    func launchAlarm(_ alarm: AlarmEntity_CoreData)
    {
        guard let ringingAlarmVC = storyboard?.instantiateViewController(withIdentifier: RingingAlarmViewController.STRYBRD_ID) as? RingingAlarmViewController else {return}
        
        ringingAlarmVC.setup(withAlarm: alarm)
        
        present(ringingAlarmVC, animated: true, completion: nil)
    }
}

