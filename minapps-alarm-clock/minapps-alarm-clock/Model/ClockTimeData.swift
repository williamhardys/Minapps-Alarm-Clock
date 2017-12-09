//
//  ClockTimeData.swift
//  minapps-alarm-clock
//
//  Created by Jibran Syed on 12/9/17.
//  Copyright © 2017 Jishenaz. All rights reserved.
//

import Foundation


struct ClockTimeData
{
    private var _hoursAbsolute: Int
    private var _minutes: Int
    private var _seconds: Int
    
    
    var hours24: Int
    {
        get
        {
            return self._hoursAbsolute
        }
    }
    
    var hours12: Int
    {
        get
        {
            let remainder = self._hoursAbsolute % 12
            
            if remainder == 0
            {
                return 12
            }
            
            return remainder
        }
    }
    
    var amOrPm: TimeMeridiem
    {
        get
        {
            if self._hoursAbsolute < 12
            {
                return .am
            }
            
            return .pm
        }
    }
    
    var minutes: Int
    {
        get
        {
            return self._minutes
        }
    }
    
    var seconds: Int
    {
        get
        {
            return self._seconds
        }
    }
    
    var hoursText24: String
    {
        get
        {
            return self.formatHourString(hourValue: self.hours24)
        }
    }
    
    var hoursText12: String
    {
        get
        {
            return self.formatHourString(hourValue: self.hours12)
        }
    }
    
    var amOrPmText: String
    {
        get
        {
            return self.amOrPm.rawValue
        }
    }
    
    var minutesText: String
    {
        get
        {
            return "\(String(format: "%02d", self._minutes))"
        }
    }
    
    var secondsText: String
    {
        get
        {
            return "\(String(format: "%02d", self._seconds))"
        }
    }
    
    
    
    init() 
    {
        self._hoursAbsolute = 0
        self._minutes = 0
        self._seconds = 0
    }
    
    init(withDate date: Date) 
    {
        self._hoursAbsolute = 0
        self._minutes = 0
        self._seconds = 0
        
        self.updateTime(withDate: date)
    }
    
    
    init(withHours hours: Int, minutes: Int, andSeconds seconds: Int) 
    {
        self._hoursAbsolute = 0
        self._minutes = 0
        self._seconds = 0
        
        self.updateTime(withHours: hours, minutes: minutes, andSeconds: seconds)
    }
    
    
    
    
    
    mutating func updateTime(withDate date: Date)
    {
        let cal = Calendar.current
        
        self._hoursAbsolute = cal.component(.hour, from: date)
        self._minutes = cal.component(.minute, from: date)
        self._seconds = cal.component(.second, from: date)
    }
    
    
    mutating func updateTime(withHours hours: Int, minutes: Int, andSeconds seconds: Int)
    {
        self._hoursAbsolute = hours % 24
        self._minutes = minutes % 60
        self._seconds = seconds % 60
    }
    
    
    private func formatHourString(hourValue: Int) -> String
    {
        let trailingHourSpace = (hourValue < 10) ? " " : ""     // Needed for consistent text layout when jumping from hr 12 to hr 01
        return "\(trailingHourSpace)\(hourValue)"
    }
    
}
