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
    
    
    var monthShort: String
    {
        get
        {
            return self.getMonthNames(from: _month, getFullName: false)
        }
    }
    
    var monthLong: String
    {
        get
        {
            return self.getMonthNames(from: _month, getFullName: true)
        }
    }
    
    var weekdayShort: String
    {
        get
        {
            return self.getWeekdayNames(from: _weekday, getFullName: false)
        }
    }
    
    var weekdayLong: String
    {
        get
        {
            return self.getWeekdayNames(from: _weekday, getFullName: true)
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
    
    init(withYear year: Int, andMonth month: Int)
    {
        self._year = 1
        self._month = 1
        self._day = 1
        self._weekday = 1
        
        self.updateDate(withYear: year, andMonth: month)
    }
    
    
    mutating func updateDate(withDate date: Date)
    {
        let cal = Calendar.current
        
        self._year = cal.component(.year, from: date)
        self._month = cal.component(.month, from: date)
        self._day = cal.component(.day, from: date)
        self._weekday = cal.component(.weekday, from: date)
    }
    
    mutating func updateDate(withYear year: Int, andMonth month: Int)
    {
        var datePacket = DateComponents()
        datePacket.year = year
        datePacket.month = month
        datePacket.day = self._day
        
        let newDate = Calendar(identifier: .gregorian).date(from: datePacket)
        
        self.updateDate(withDate: newDate!)
    }
    
    
    private func getMonthNames(from monthNumber: Int, getFullName: Bool) -> String
    {
        var monthName = ""
        
        if getFullName
        {
            switch monthNumber
            {
            case 1:
                monthName = "january"
                break
            case 2:
                monthName = "february"
                break
            case 3:
                monthName = "march"
                break
            case 4:
                monthName = "april"
                break
            case 5:
                monthName = "may"
                break
            case 6:
                monthName = "june"
                break
            case 7:
                monthName = "july"
                break
            case 8:
                monthName = "august"
                break
            case 9:
                monthName = "september"
                break
            case 10:
                monthName = "october"
                break
            case 11:
                monthName = "november"
                break
            case 12:
                monthName = "december"
                break
            default:
                monthName = "error_invalid_month"
                break
            }
        }
        else    // getShortName
        {
            switch monthNumber
            {
            case 1:
                monthName = "jan"
                break
            case 2:
                monthName = "feb"
                break
            case 3:
                monthName = "mar"
                break
            case 4:
                monthName = "apr"
                break
            case 5:
                monthName = "may"
                break
            case 6:
                monthName = "jun"
                break
            case 7:
                monthName = "jul"
                break
            case 8:
                monthName = "aug"
                break
            case 9:
                monthName = "sep"
                break
            case 10:
                monthName = "oct"
                break
            case 11:
                monthName = "nov"
                break
            case 12:
                monthName = "dec"
                break
            default:
                monthName = "error_invalid_short_month"
                break
            }
        }
        
        return monthName
    }
    
    
    private func getWeekdayNames(from weekdayNumber: Int, getFullName: Bool) -> String 
    {
        var weekdayName = ""
        
        if getFullName
        {
            switch weekdayNumber
            {
            case 1:
                weekdayName = "sunday"
                break
            case 2:
                weekdayName = "monday"
                break
            case 3:
                weekdayName = "tuesday"
                break
            case 4:
                weekdayName = "wednesday"
                break
            case 5:
                weekdayName = "thursday"
                break
            case 6:
                weekdayName = "friday"
                break
            case 7:
                weekdayName = "saturday"
                break
            default:
                weekdayName = "error_invalid_weekday"
                break
            }
        }
        else // get short name
        {
            switch weekdayNumber
            {
            case 1:
                weekdayName = "sun"
                break
            case 2:
                weekdayName = "mon"
                break
            case 3:
                weekdayName = "tue"
                break
            case 4:
                weekdayName = "wed"
                break
            case 5:
                weekdayName = "thu"
                break
            case 6:
                weekdayName = "fri"
                break
            case 7:
                weekdayName = "sat"
                break
            default:
                weekdayName = "error_invalid_short_weekday"
                break
            }
        }
        
        return weekdayName
    }
    
    
    
    
    
}
