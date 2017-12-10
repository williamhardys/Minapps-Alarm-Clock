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
    
    
    private var clockTimer: Timer?
    private var clockData = ClockTimeData()
    private var dateData = ClockDateData()
    
    
    override func viewDidLoad() 
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Needed to prevent user from seeing 00:00 on app start
        self.updateClockFace()
        
        // Just in case
        self.stopClockTimer()
        
        // Initialize
        self.initializeClockTimer()
    }
    
    override func viewWillAppear(_ animated: Bool) 
    {
        super.viewWillAppear(animated)
        
        if self.clockTimer?.isValid == false
        {
            self.stopClockTimer()
            self.initializeClockTimer()
        }
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
    
    
    private func initializeClockTimer()
    {
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
    
}

