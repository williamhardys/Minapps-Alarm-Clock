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
    
    
    
    override func viewDidLoad() 
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.updateClockFace()
        
        // Just in case
        self.clockTimer?.invalidate()
        
        // Initialize
        self.initializeClockTimer()
    }
    
    override func viewWillAppear(_ animated: Bool) 
    {
        super.viewWillAppear(animated)
        
        if self.clockTimer?.isValid == false
        {
            self.initializeClockTimer()
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) 
    {
        self.clockTimer?.invalidate()
        
        super.viewWillDisappear(animated)
    }
    
    
    override func didReceiveMemoryWarning() 
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        self.clockTimer?.invalidate()
    }
    
    
    private func initializeClockTimer()
    {
        self.clockTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (timer) in
            self.updateClockFace()
        })
    }
    
    
    private func updateClockFace()
    {
        let currentTime = Date()
        let cal = Calendar.current
        
        let hours = cal.component(.hour, from: currentTime)
        let minutes = cal.component(.minute, from: currentTime)
        let seconds = cal.component(.second, from: currentTime)
        
        
        self.lblHoursAndMinutes.text = "\(hours):\(String(format: "%02d", minutes))"
        self.lblSeconds.text = ":\(String(format: "%02d", seconds))"
    }
    
}

