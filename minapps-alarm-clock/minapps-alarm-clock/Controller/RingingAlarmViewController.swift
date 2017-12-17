//
//  RingingAlarmViewController.swift
//  minapps-alarm-clock
//
//  Created by Jibran Syed on 12/16/17.
//  Copyright © 2017 Jishenaz. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation

class RingingAlarmViewController: UIViewController 
{
    static let STRYBRD_ID = "RingingAlarmVC"
    
    @IBOutlet weak var btnSnooze: UIButton!
    @IBOutlet weak var btnStop: UIButton!
    @IBOutlet weak var lblAlarmTime: UILabel!
    @IBOutlet weak var lblAlarmName: UILabel!
    @IBOutlet weak var lblRingingNowText: UILabel!
    
    private var alarm: AlarmEntity_CoreData!
    private var audioPlayer: AVAudioPlayer!
    
    
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
        
        if alarm.snoozeEnabled
        {
            self.btnSnooze.isHidden = false
            self.btnSnooze.setTitle("Snooze (\(Int(self.alarm.snoozeDuration)) min)", for: .normal)
        }
        else
        {
            self.btnSnooze.isHidden = true
        }
        
        
        // Load alarm sound
        let audioFilePath = Bundle.main.path(forResource: self.alarm.soundName, ofType: "wav")
        
        if audioFilePath != nil 
        {
            let audioFileUrl = NSURL.fileURL(withPath: audioFilePath!)
            
            do
            {
                self.audioPlayer = try AVAudioPlayer(contentsOf: audioFileUrl)
                audioPlayer.prepareToPlay()
                audioPlayer.numberOfLoops = -1  // Infinite looping sound
                audioPlayer.volume = 1.0
            }
            catch
            {
                print("ERROR: AudioPlayer for \(self.alarm.soundName ?? "Undefined sound file") could not get initialized!")
                debugPrint(error.localizedDescription)
            }
        }
        else 
        {
            print("ERROR: Audio File \(self.alarm.soundName ?? "Undefined sound file") was not found!")
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) 
    {
        self.audioPlayer.stop()
        self.audioPlayer.currentTime = 0.0
        
        super.viewWillDisappear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.audioPlayer.play()
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
    
    
    
    private func stopAlarm(doSnooze: Bool)
    {
        if doSnooze
        {
            // Setup snooze timer
            AlarmService.instance.scheduleSnooze(forAlarm: self.alarm)
        }
        else
        {
            AlarmService.instance.cancelSnooze()
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func onSnoozeBtnPressed(_ sender: Any) 
    {
        self.stopAlarm(doSnooze: true)
    }
    
    
    @IBAction func onStopBtnPressed(_ sender: Any) 
    {
        self.stopAlarm(doSnooze: false)
    }
    
    
}
