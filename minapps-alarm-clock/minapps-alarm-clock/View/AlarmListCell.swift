//
//  AlarmListCell.swift
//  minapps-alarm-clock
//
//  Created by Jibran Syed on 12/13/17.
//  Copyright © 2017 Jishenaz. All rights reserved.
//

import UIKit
import CoreData

class AlarmListCell: UITableViewCell 
{
    static let REUSE_ID = "AlarmListCell"
    
    @IBOutlet weak var lblAlarmTime: UILabel!
    @IBOutlet weak var lblAlarmName: UILabel!
    @IBOutlet weak var switchAlarmEnabled: UISwitch!
    
    private var alarm: AlarmEntity_CoreData!
    
    
    override func awakeFromNib() 
    {
        super.awakeFromNib()
        // Initialization code
        self.switchAlarmEnabled.onTintColor = SettingsService.instance.getColor()
    }
    
    
    func setupCell(withAlarm newAlarm: AlarmEntity_CoreData)
    {
        self.alarm = newAlarm
        let alarmTime = ClockTimeData(withHours: Int(newAlarm.timeHour24), minutes: Int(newAlarm.timeMinute), andSeconds: 0)
        
        var hoursText = ""
        var amOrPmText = ""
        if SettingsService.instance.isUsing24HourConvention()
        {
            hoursText = alarmTime.hoursText24
        }
        else
        {
            hoursText = alarmTime.hoursText12
            amOrPmText = " \(alarmTime.amOrPmText)"
        }
        
        self.lblAlarmTime.text = "\(hoursText):\(alarmTime.minutesText)\(amOrPmText)"
        
        self.lblAlarmName.text = newAlarm.alarmName ?? "Unnamed Alarm"
        
        self.switchAlarmEnabled.setOn(newAlarm.alarmEnabled, animated: false)
    }
    
    
    @IBAction func onSwitchChanged(_ sender: UISwitch) 
    {
        self.alarm.alarmEnabled = sender.isOn
        
        CoreDataService.instance.saveAllEntities { (success) in
            if success
            {
                print("Alarm was successfully disabled")
            }
            else
            {
                print("Alarm failed to be disabled")
            }
        }
    }
    
    
}
