//
//  ModifyAlarmViewController.swift
//  minapps-alarm-clock
//
//  Created by Jibran Syed on 12/13/17.
//  Copyright © 2017 Jishenaz. All rights reserved.
//

import UIKit
import CoreData

class ModifyAlarmViewController: UITableViewController 
{
    static let STRYBRD_ID = "ModifyAlarmVC"
    
    @IBOutlet var staticTableAlarmSettings: UITableView!
    @IBOutlet weak var datePickerAlarmTime: UIDatePicker!
    @IBOutlet weak var switchSunday: UISwitch!
    @IBOutlet weak var switchMonday: UISwitch!
    @IBOutlet weak var switchTuesday: UISwitch!
    @IBOutlet weak var switchWednesday: UISwitch!
    @IBOutlet weak var switchThursday: UISwitch!
    @IBOutlet weak var switchFriday: UISwitch!
    @IBOutlet weak var switchSaturday: UISwitch!
    @IBOutlet weak var txtFieldAlarmName: UITextField!
    @IBOutlet weak var pickerAlarmSound: UIPickerView!
    @IBOutlet weak var switchSnooze: UISwitch!
    @IBOutlet weak var stepperSnoozeTime: UIStepper!
    @IBOutlet weak var lblSnoozeTime: UILabel!
    
    
    private var alarm: AlarmEntity_CoreData!
    
    
    var testPickerData: [String] = []
    
    
    override func viewDidLoad() 
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.staticTableAlarmSettings.allowsSelection = false
        self.pickerAlarmSound.delegate = self
        self.pickerAlarmSound.dataSource = self
        
        self.testPickerData = ["One", "Two", "Three", "Four", "Five"]
        
        self.changeSwitchActiveColors( SettingsService.instance.getColor() )
        
        let alarmClockTime = ClockTimeData(withHours: Int(alarm.timeHour24), minutes: Int(alarm.timeMinute), andSeconds: 0)
        self.datePickerAlarmTime.date = alarmClockTime.makeDateObject()
    }
    
    override func viewWillDisappear(_ animated: Bool) 
    {
        // Uncomment when ready vvv
//        CoreDataService.instance.saveAllEntities { (success) in
//            if success
//            {
//                print("Alarm was successfully edited")
//            }
//            else
//            {
//                print("Alarm failed to be edited")
//            }
//        }
        
        super.viewWillDisappear(animated)
    }
    
    
    
    func loadAlarm(_ passedAlarm: AlarmEntity_CoreData)
    {
        self.alarm = passedAlarm
    }
    
    
    func changeSwitchActiveColors(_ color: UIColor)
    {
        self.switchSunday.onTintColor = color
        self.switchMonday.onTintColor = color
        self.switchTuesday.onTintColor = color
        self.switchWednesday.onTintColor = color
        self.switchThursday.onTintColor = color
        self.switchFriday.onTintColor = color
        self.switchSaturday.onTintColor = color
        self.switchSnooze.onTintColor = color
        self.stepperSnoozeTime.tintColor = color
    }
    
    
    
    @IBAction func onDoneBtnPressed(_ sender: Any) 
    {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onAlarmTimePickerChanged(_ sender: UIDatePicker) 
    {
        let alarmTime = ClockTimeData(withDate: sender.date)
        self.alarm.timeHour24 = Int16(alarmTime.hours24)
        self.alarm.timeMinute = Int16(alarmTime.minutes)
    }
    
    @IBAction func onSundaySwitchChanged(_ sender: UISwitch) 
    {
        
    }
    
    @IBAction func onMondaySwitchChanged(_ sender: UISwitch) 
    {
        
    }
    
    @IBAction func onTuesdaySwitchChanged(_ sender: UISwitch) 
    {
        
    }
    
    @IBAction func onWednesdaySwitchChanged(_ sender: UISwitch) 
    {
        
    }
    
    @IBAction func onThursdaySwitchChanged(_ sender: UISwitch) 
    {
        
    }
    
    @IBAction func onFridaySwitchChanged(_ sender: UISwitch) 
    {
        
    }
    
    @IBAction func onSaturdaySwitchChanged(_ sender: UISwitch) 
    {
        
    }
    
    @IBAction func onAlarmNameEditingEnded(_ sender: UITextField) 
    {
        
    }
    
    @IBAction func onSnoozeSwitchChanged(_ sender: UISwitch) 
    {
        
    }
    
    @IBAction func onSnoozeStepperChanged(_ sender: UIStepper) 
    {
        
    }
    
}


extension ModifyAlarmViewController: UIPickerViewDelegate, UIPickerViewDataSource
{
    // Columns in the picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int 
    {
        return 1
    }
    
    // Number of rows
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int 
    {
        return self.testPickerData.count
    }
    
    // Populate picker with data to select
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? 
    {
        return self.testPickerData[row]
    }
    
    // When the picker selects something
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) 
    {
        self.alarm.soundName = self.testPickerData[row]
    }
}






