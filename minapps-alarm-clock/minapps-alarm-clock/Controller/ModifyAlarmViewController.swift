//
//  ModifyAlarmViewController.swift
//  minapps-alarm-clock
//
//  Created by Jibran Syed on 12/13/17.
//  Copyright © 2017 Jishenaz. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation

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
    private var audioPlayers: [AVAudioPlayer] = []
    
    private var alarmSoundNames: [String] = []
    private var alarmSoundFiles: [String] = []
    
    
    override func viewDidLoad() 
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.staticTableAlarmSettings.allowsSelection = false
        self.pickerAlarmSound.delegate = self
        self.pickerAlarmSound.dataSource = self
        self.txtFieldAlarmName.delegate = self
        
        self.loadAlarmSoundData()
        
        self.changeSwitchActiveColors( SettingsService.instance.getColor() )
        
        let alarmClockTime = ClockTimeData(withHours: Int(alarm.timeHour24), minutes: Int(alarm.timeMinute), andSeconds: 0)
        self.datePickerAlarmTime.date = alarmClockTime.makeDateObject()
        
        self.txtFieldAlarmName.text = self.alarm.alarmName
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTap))
        self.view.addGestureRecognizer(tap)
        
        self.pickerAlarmSound.selectRow(Int(self.alarm.soundIndex), inComponent: 0, animated: false)
        
        self.stepperSnoozeTime.value = self.alarm.snoozeDuration
        self.lblSnoozeTime.text = "\(Int(self.alarm.snoozeDuration)) min"
        
        self.switchSunday.isOn = self.alarm.repeatOnSunday
        self.switchMonday.isOn = self.alarm.repeatOnMonday
        self.switchTuesday.isOn = self.alarm.repeatOnTuesday
        self.switchWednesday.isOn = self.alarm.repeatOnWednesday
        self.switchThursday.isOn = self.alarm.repeatOnThursday
        self.switchFriday.isOn = self.alarm.repeatOnFriday
        self.switchSaturday.isOn = self.alarm.repeatOnSaturday
        self.switchSnooze.isOn = self.alarm.snoozeEnabled
    }
    
    override func viewWillDisappear(_ animated: Bool) 
    {
        self.stopAllSounds()
        
        CoreDataService.instance.saveAllEntities { (success) in
            if success
            {
                print("Alarm was successfully edited")
            }
            else
            {
                print("Alarm failed to be edited")
            }
        }
        
        super.viewWillDisappear(animated)
    }
    
    
    
    func loadAlarm(_ passedAlarm: AlarmEntity_CoreData)
    {
        self.alarm = passedAlarm
    }
    
    
    private func changeSwitchActiveColors(_ color: UIColor)
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
    
    
    private func loadAlarmSoundData()
    {
        var soundRegistry: NSDictionary?
        if let soundRegistryPath = Bundle.main.path(forResource: "AlarmSounds", ofType: "plist") 
        {
            soundRegistry = NSDictionary(contentsOfFile: soundRegistryPath)
        }
        if let registry = soundRegistry 
        {
            self.alarmSoundNames = registry.value(forKey: "Alarm Sound Names") as! [String]
            self.alarmSoundFiles = registry.value(forKey: "Alarm Sound Files") as! [String]
            
            for i in 0..<self.alarmSoundNames.count
            {
                let audioFilePath = Bundle.main.path(forResource: self.alarmSoundFiles[i], ofType: "wav")
                
                if audioFilePath != nil 
                {
                    let audioFileUrl = NSURL.fileURL(withPath: audioFilePath!)
                    
                    do
                    {
                        let audioPlayer = try AVAudioPlayer(contentsOf: audioFileUrl)
                        audioPlayer.prepareToPlay()
                        audioPlayer.numberOfLoops = 0
                        self.audioPlayers.append(audioPlayer)
                    }
                    catch
                    {
                        print("ERROR: AudioPlayer for \(self.alarmSoundNames[i]) could not get initialized!")
                        debugPrint(error.localizedDescription)
                    }
                }
                else 
                {
                    print("ERROR: Audio File \(self.alarmSoundNames[i]) was not found!")
                }
            }
        }
    }
    
    
    private func stopAllSounds()
    {
        // Stop all sounds
        for i in 0 ..< self.audioPlayers.count
        {
            self.audioPlayers[i].stop()
            self.audioPlayers[i].currentTime = 0.0
        }
    }
    
    
    @objc
    private func onTap()
    {
        self.view.endEditing(true)
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
        self.alarm.repeatOnSunday = sender.isOn
    }
    
    @IBAction func onMondaySwitchChanged(_ sender: UISwitch) 
    {
        self.alarm.repeatOnMonday = sender.isOn
    }
    
    @IBAction func onTuesdaySwitchChanged(_ sender: UISwitch) 
    {
        self.alarm.repeatOnTuesday = sender.isOn
    }
    
    @IBAction func onWednesdaySwitchChanged(_ sender: UISwitch) 
    {
        self.alarm.repeatOnWednesday = sender.isOn
    }
    
    @IBAction func onThursdaySwitchChanged(_ sender: UISwitch) 
    {
        self.alarm.repeatOnThursday = sender.isOn
    }
    
    @IBAction func onFridaySwitchChanged(_ sender: UISwitch) 
    {
        self.alarm.repeatOnFriday = sender.isOn
    }
    
    @IBAction func onSaturdaySwitchChanged(_ sender: UISwitch) 
    {
        self.alarm.repeatOnSaturday = sender.isOn
    }
    
    @IBAction func onAlarmNameEditingEnded(_ sender: UITextField) 
    {
        var newName = "Alarm"
        if sender.text != nil
        {
            newName = sender.text!
        }
        
        self.alarm.alarmName = newName
    }
    
    @IBAction func onSnoozeSwitchChanged(_ sender: UISwitch) 
    {
        self.alarm.snoozeEnabled = sender.isOn
    }
    
    @IBAction func onSnoozeStepperChanged(_ sender: UIStepper) 
    {
        let newValue = sender.value
        self.lblSnoozeTime.text = "\(Int(newValue)) min"
        self.alarm.snoozeDuration = newValue
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
        return self.alarmSoundNames.count
    }
    
    // Populate picker with data to select
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? 
    {
        return self.alarmSoundNames[row]
    }
    
    // When the picker selects something
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) 
    {
        self.alarm.soundIndex = Int32(row)
        self.alarm.soundName = self.alarmSoundFiles[row]
        
        self.stopAllSounds()
        
        // Play only the selected sound
        self.audioPlayers[row].play()
    }
}



extension ModifyAlarmViewController: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool 
    {
        textField.resignFirstResponder()
        return true
    }
}





