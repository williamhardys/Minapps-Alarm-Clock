//
//  ClockDateData.swift
//  minapps-alarm-clock
//
//  Created by Jibran Syed on 12/9/17.
//  Copyright © 2017 Jishenaz. All rights reserved.
//

import Foundation

struct ClockDateData
{
    private var _year: Int
    private var _month: Int
    private var _day: Int
    private var _weekday: Int
    
    
    var year: Int
    {
        get
        {
            return self._year
        }
    }
    
    var monthNumber: Int
    {
        get
        {
            return self._month
        }
    }
    
    var day: Int
    {
        get
        {
            return self._day
        }
    }
    
    var weekdayNumber: Int
    {
        get
        {
            return self._weekday
        }
    }
    
    
    
    init()
    {
        self._year = 1
        self._month = 1
        self._day = 1
        self._weekday = 1
    }
    
    init(withDate date: Date) 
    {
        self._year = 1
        self._month = 1
        self._day = 1
        self._weekday = 1
        
        self.updateDate(withDate: date)
    }
    
    
    
    mutating func updateDate(withDate date: Date)
    {
        let cal = Calendar.current
        
        self._year = cal.component(.year, from: date)
        self._month = cal.component(.year, from: date)
        self._day = cal.component(.year, from: date)
        self._weekday = cal.component(.year, from: date)
    }
    
}
