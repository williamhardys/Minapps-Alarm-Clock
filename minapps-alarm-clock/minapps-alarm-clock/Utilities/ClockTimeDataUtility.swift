//
//  ClockTimeDataUtility.swift
//  minapps-alarm-clock
//
//  Created by Jibran Syed on 12/16/17.
//  Copyright © 2017 Jishenaz. All rights reserved.
//

import Foundation

enum ClockTimeDataUtility
{
    // From the origin time, create a date object for the given target time. The date object will either be this day or next day
    static func makeFutureDateFrom(target: ClockTimeData, with origin: ClockTimeData) -> Date
    {
        if target > origin
        {
            return ClockTimeDataUtility.makeDateForTodayFrom(target: target)
        }
        else
        {
            return ClockTimeDataUtility.makeDateForNextDayFrom(target: target)
        }
    }
    
    static func makeDateForTodayFrom(target: ClockTimeData) -> Date
    {
        // Get today's date
        let todaysDate = Date()
        let cal = Calendar.current
        let thisYear = cal.component(.year, from: todaysDate)
        let thisMonth = cal.component(.month, from: todaysDate)
        let thisDay = cal.component(.day, from: todaysDate)
        
        // Build a new date for today with the target time
        var dateData = DateComponents()
        dateData.year = thisYear
        dateData.month = thisMonth
        dateData.day = thisDay
        dateData.hour = target.hours24
        dateData.minute = target.minutes
        dateData.second = 0
        
        // Create date from components        
        return cal.date(from: dateData)!
    }
    
    
    static func makeDateForNextDayFrom(target: ClockTimeData) -> Date
    {
        // Create a date for today
        var date = ClockTimeDataUtility.makeDateForTodayFrom(target: target)
        
        // Add one whole day (86,400 seconds) to the date
        date.addTimeInterval(86_400.0)
        
        return date
    }
    
}