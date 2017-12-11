//
//  ClockViewController.swift
//  minapps-alarm-clock
//
//  Created by Jibran Syed on 12/8/17.
//  Copyright © 2017 Jishenaz. All rights reserved.
//

import UIKit

class ClockViewController: UIViewController 
{
    @IBOutlet weak var lblHoursAndMinutes: UILabel!
    @IBOutlet weak var lblSeconds: UILabel!
    @IBOutlet weak var lblAmOrPm: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblBatteryGadge: UILabel!
    @IBOutlet weak var imgBell: UIImageView!
    @IBOutlet weak var imgBattery: UIImageView!
    @IBOutlet weak var btnGear: UIButton!
    @IBOutlet weak var lblAlarmInfo: UILabel!
    
    
    private var clockTimer: Timer?
    private var clockData = ClockTimeData()
    private var dateData = ClockDateData()
    
    
    override func viewDidLoad() 
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        self.setupColor(SettingsService.instance.getColor())
        
        // Setup battery monitoring
        UIDevice.current.isBatteryMonitoringEnabled = true
        NotificationCenter.default.addObserver(self, selector: #selector(onBatteryLevelChanged(_:)), name: .UIDeviceBatteryLevelDidChange, object: nil)
        self.updateBatteryGadge()
        
        // Needed to prevent user from seeing 00:00 on app start
        self.updateClockFace()
        
        // Initialize
        self.initializeClockTimer()
    }
    
    override func viewWillAppear(_ animated: Bool) 
    {
        super.viewWillAppear(animated)
        
        self.updateClockFace()
        
        if self.clockTimer?.isValid == false
        {
            self.stopClockTimer()
            self.initializeClockTimer()
        }
        
        self.updateClockFace()
        self.updateBatteryGadge()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) 
    {
        self.stopClockTimer()
        
        super.viewWillDisappear(animated)
    }
    
    
    override func didReceiveMemoryWarning() 
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        self.stopClockTimer()
    }
    
    
    private var batteryPercentage: Int
    {
        get
        {
            return Int(UIDevice.current.batteryLevel * 100.0)
        }
    }
    
    
    func setupColor(_ newColor: UIColor)
    {
        self.btnGear.imageView?.tintColor = newColor
        self.imgBell.tintColor = newColor
        self.imgBattery.tintColor = newColor
        self.lblBatteryGadge.textColor = newColor
        self.lblDate.textColor = newColor
        self.lblAmOrPm.textColor = newColor
        self.lblSeconds.textColor = newColor
        self.lblAlarmInfo.textColor = newColor
        self.lblHoursAndMinutes.textColor = newColor
    }
    
    
    private func initializeClockTimer()
    {
        self.stopClockTimer()
        
        self.clockTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (timer) in
            self.updateClockFace()
        })
    }
    
    
    private func stopClockTimer()
    {
        self.clockTimer?.invalidate()
        self.clockTimer = nil
    }
    
    
    private func updateClockFace()
    {
        let currentDateTime = Date()
        
        // Get current time
        self.clockData.updateTime(withDate: currentDateTime)
        
        // Output string values
        self.lblHoursAndMinutes.text = "\(clockData.hoursText12):\(clockData.minutesText)"
        self.lblSeconds.text = ":\(clockData.secondsText)"
        self.lblAmOrPm.text = " \(clockData.amOrPmText.uppercased())"
        
        
        // Get current date
        self.dateData.updateDate(withDate: currentDateTime)
        
        // Update string values
        self.lblDate.text = "\(dateData.weekdayShort.uppercased()), \(dateData.monthShort.uppercased()) \(dateData.day) \(dateData.year)"
    }
    
    
    private func updateBatteryGadge()
    {
        self.lblBatteryGadge.text = "\(self.batteryPercentage)%"
    }
    
    
    @objc
    func onBatteryLevelChanged(_ notification: Notification)
    {
        self.updateBatteryGadge()
    }
    
    
    
    
    @IBAction func onSettingsBtnPressed(_ sender: Any) 
    {
        if let appSettings = URL(string: UIApplicationOpenSettingsURLString)
        {
            UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func onAlarmBtnPressed(_ sender: Any) 
    {
        
    }
    
    
    
}

