//
//  ClockDateDataTests.swift
//  minapps-alarm-clockTests
//
//  Created by Jibran Syed on 12/9/17.
//  Copyright © 2017 Jishenaz. All rights reserved.
//

import XCTest
@testable import minapps_alarm_clock

class ClockDateDataTests: XCTestCase 
{
    
    override func setUp() 
    {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() 
    {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    
    func testYear()
    {
        let currentDate = Date()
        let targetYear = Calendar.current.component(.year, from: currentDate)
        
        let dateData = ClockDateData(withDate: Date())
        
        XCTAssertEqual(dateData.year, targetYear)
    }
    
    func testMonthNumber()
    {
        let currentDate = Date()
        let targetMonth = Calendar.current.component(.month, from: currentDate)
        
        let dateData = ClockDateData(withDate: Date())
        
        XCTAssertEqual(dateData.monthNumber, targetMonth)
    }
    
    func testDay()
    {
        let currentDate = Date()
        let targetDay = Calendar.current.component(.day, from: currentDate)
        
        let dateData = ClockDateData(withDate: Date())
        
        XCTAssertEqual(dateData.day, targetDay)
    }
    
    func testWeekdayNumber()
    {
        let currentDate = Date()
        let targetWeekday = Calendar.current.component(.weekday, from: currentDate)
        
        let dateData = ClockDateData(withDate: Date())
        
        XCTAssertEqual(dateData.weekdayNumber, targetWeekday)
    }
    
    
    func testWeekdayName()
    {
        var date = Date(timeIntervalSinceReferenceDate: 0) // Since 12-31-00 in Chicago
        var dateData = ClockDateData(withDate: date)
        XCTAssertEqual(dateData.weekdayShort, "sun")
        XCTAssertEqual(dateData.weekdayLong, "sunday")
        
        date = Date(timeIntervalSinceReferenceDate: 86400 * 1)
        dateData = ClockDateData(withDate: date)
        XCTAssertEqual(dateData.weekdayShort, "mon")
        XCTAssertEqual(dateData.weekdayLong, "monday")
        
        date = Date(timeIntervalSinceReferenceDate: 86400 * 2)
        dateData = ClockDateData(withDate: date)
        XCTAssertEqual(dateData.weekdayShort, "tue")
        XCTAssertEqual(dateData.weekdayLong, "tuesday")
        
        date = Date(timeIntervalSinceReferenceDate: 86400 * 3)
        dateData = ClockDateData(withDate: date)
        XCTAssertEqual(dateData.weekdayShort, "wed")
        XCTAssertEqual(dateData.weekdayLong, "wednesday")
        
        date = Date(timeIntervalSinceReferenceDate: 86400 * 4)
        dateData = ClockDateData(withDate: date)
        XCTAssertEqual(dateData.weekdayShort, "thu")
        XCTAssertEqual(dateData.weekdayLong, "thursday")
        
        date = Date(timeIntervalSinceReferenceDate: 86400 * 5)
        dateData = ClockDateData(withDate: date)
        XCTAssertEqual(dateData.weekdayShort, "fri")
        XCTAssertEqual(dateData.weekdayLong, "friday")
        
        date = Date(timeIntervalSinceReferenceDate: 86400 * 6)
        dateData = ClockDateData(withDate: date)
        XCTAssertEqual(dateData.weekdayShort, "sat")
        XCTAssertEqual(dateData.weekdayLong, "saturday")
    }
    
    func testMonthName()
    {
        var dateData = ClockDateData(withYear: 2017, andMonth: 1)
        XCTAssertEqual(dateData.monthShort, "jan")
        XCTAssertEqual(dateData.monthLong, "january")
        
        dateData.updateDate(withYear: 2017, andMonth: 2)
        XCTAssertEqual(dateData.monthShort, "feb")
        XCTAssertEqual(dateData.monthLong, "february")
        
        dateData.updateDate(withYear: 2017, andMonth: 3)
        XCTAssertEqual(dateData.monthShort, "mar")
        XCTAssertEqual(dateData.monthLong, "march")
        
        dateData.updateDate(withYear: 2017, andMonth: 4)
        XCTAssertEqual(dateData.monthShort, "apr")
        XCTAssertEqual(dateData.monthLong, "april")
        
        dateData.updateDate(withYear: 2017, andMonth: 5)
        XCTAssertEqual(dateData.monthShort, "may")
        XCTAssertEqual(dateData.monthLong, "may")
        
        dateData.updateDate(withYear: 2017, andMonth: 6)
        XCTAssertEqual(dateData.monthShort, "jun")
        XCTAssertEqual(dateData.monthLong, "june")
        
        dateData.updateDate(withYear: 2017, andMonth: 7)
        XCTAssertEqual(dateData.monthShort, "jul")
        XCTAssertEqual(dateData.monthLong, "july")
        
        dateData.updateDate(withYear: 2017, andMonth: 8)
        XCTAssertEqual(dateData.monthShort, "aug")
        XCTAssertEqual(dateData.monthLong, "august")
        
        dateData.updateDate(withYear: 2017, andMonth: 9)
        XCTAssertEqual(dateData.monthShort, "sep")
        XCTAssertEqual(dateData.monthLong, "september")
        
        dateData.updateDate(withYear: 2017, andMonth: 10)
        XCTAssertEqual(dateData.monthShort, "oct")
        XCTAssertEqual(dateData.monthLong, "october")
        
        dateData.updateDate(withYear: 2017, andMonth: 11)
        XCTAssertEqual(dateData.monthShort, "nov")
        XCTAssertEqual(dateData.monthLong, "november")
        
        dateData.updateDate(withYear: 2017, andMonth: 12)
        XCTAssertEqual(dateData.monthShort, "dec")
        XCTAssertEqual(dateData.monthLong, "december")
    }
    
}
