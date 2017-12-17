//
//  RingingAlarmViewController.swift
//  minapps-alarm-clock
//
//  Created by Jibran Syed on 12/16/17.
//  Copyright © 2017 Jishenaz. All rights reserved.
//

import UIKit
import CoreData

class RingingAlarmViewController: UIViewController 
{
    static let STRYBRD_ID = "RingingAlarmVC"
    
    @IBOutlet weak var btnSnooze: UIButton!
    @IBOutlet weak var btnStop: UIButton!
    @IBOutlet weak var lblAlarmTime: UILabel!
    @IBOutlet weak var lblAlarmName: UILabel!
    @IBOutlet weak var lblRingingNowText: UILabel!
    
    private var alarm: AlarmEntity_CoreData!
    
    
    
    override func viewDidLoad() 
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.updateFont(SettingsService.instance.getFont())
        self.updateColor(SettingsService.instance.getColor())
        
        let alarmTime = ClockTimeData(withHours: Int(alarm.timeHour24), minutes: Int(alarm.timeMinute), andSeconds: 0)
        if SettingsService.instance.isUsing24HourConvention()
        {
            self.lblAlarmTime.text = alarmTime.timeText24WithoutSeconds
        }
        else
        {
            self.lblAlarmTime.text = alarmTime.timeText12WithoutSeconds
        }
        
        self.lblAlarmName.text = self.alarm.alarmName ?? "Unnamed Alarm"
        
        self.btnSnooze.titleLabel!.text = "Snooze (\(Int(self.alarm.snoozeDuration)) min"
    }
    
    
    
    func setup(withAlarm newAlarm: AlarmEntity_CoreData)
    {
        self.alarm = newAlarm
    }
    
    
    func updateFont(_ fontName: String)
    {
        self.btnSnooze.titleLabel!.font = UIFont(name: fontName, size: btnSnooze.titleLabel!.font.pointSize)
        self.btnStop.titleLabel!.font = UIFont(name: fontName, size: btnStop.titleLabel!.font.pointSize)
        self.lblAlarmTime.font = UIFont(name: fontName, size: lblAlarmTime.font.pointSize)
        self.lblAlarmName.font = UIFont(name: fontName, size: lblAlarmName.font.pointSize)
        self.lblRingingNowText.font = UIFont(name: fontName, size: lblRingingNowText.font.pointSize)
    }
    
    func updateColor(_ themeColor: UIColor)
    {
        self.view.backgroundColor = themeColor
        self.btnStop.setTitleColor(themeColor, for: .normal)
    }
    
    
    @IBAction func onSnoozeBtnPressed(_ sender: Any) 
    {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func onStopBtnPressed(_ sender: Any) 
    {
        dismiss(animated: true, completion: nil)
    }
    
    
}
