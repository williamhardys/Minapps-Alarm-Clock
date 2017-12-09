//
//  ClockTimeData.swift
//  minapps-alarm-clock
//
//  Created by Jibran Syed on 12/9/17.
//  Copyright © 2017 Jishenaz. All rights reserved.
//

import Foundation


class ClockTimeData
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
            return self._hoursAbsolute
        }
    }
    
    var amOrPm: TimeMeridiem
    {
        get
        {
            return .am
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
    
    
    func updateTime(withDate date: Date)
    {
        let cal = Calendar.current
        
        self._hoursAbsolute = cal.component(.hour, from: date)
        self._minutes = cal.component(.minute, from: date)
        self._seconds = cal.component(.second, from: date)
    }
    
    
    func updateTime(withHours hours: Int, minutes: Int, andSeconds seconds: Int)
    {
        self._hoursAbsolute = hours
        self._minutes = minutes
        self._seconds = seconds
        
        if _hoursAbsolute > 23
        {
            _hoursAbsolute = 23
        }
        else if _hoursAbsolute < 0
        {
            _hoursAbsolute = 0
        }
        
        if _minutes > 59
        {
            _minutes = 59
        }
        else if _minutes < 0
        {
            _minutes = 0
        }
        
        if _seconds > 59
        {
            _seconds = 59
        }
        else if _seconds < 0
        {
            _seconds = 0
        }
    }
    
}
