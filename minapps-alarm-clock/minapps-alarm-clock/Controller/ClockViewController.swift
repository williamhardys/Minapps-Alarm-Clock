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
    
    
    private var clockTimer: Timer?
    private var clockData = ClockTimeData()
    
    
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
        /*
        let currentTime = Date()
        let cal = Calendar.current
        
        let hours = cal.component(.hour, from: currentTime)
        let minutes = cal.component(.minute, from: currentTime)
        let seconds = cal.component(.second, from: currentTime)
        
        let trailingHourSpace = (hours < 10) ? " " : ""     // Needed for consistent text layout when jumping from hr 12 to hr 01
        
        self.lblHoursAndMinutes.text = "\(trailingHourSpace)\(hours):\(String(format: "%02d", minutes))"
        self.lblSeconds.text = ":\(String(format: "%02d", seconds))"
         */
        
        // Get current time
        self.clockData = ClockTimeData(withDate: Date())
        
        // Output string values
        self.lblHoursAndMinutes.text = "\(self.clockData.hoursText24):\(self.clockData.minutesText)"
        self.lblSeconds.text = ":\(self.clockData.secondsText)"
    }
    
}

