//
//  ClockTimeDataTests.swift
//  minapps-alarm-clockTests
//
//  Created by Jibran Syed on 12/9/17.
//  Copyright © 2017 Jishenaz. All rights reserved.
//

import XCTest
@testable import minapps_alarm_clock

class ClockTimeDataTests: XCTestCase 
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
    
    
    func testInitWithDate()
    {
        let currentDate = Date()
        let targetHours = Calendar.current.component(.hour, from: currentDate)
        let targetMinutes = Calendar.current.component(.minute, from: currentDate)
        let targetSeconds = Calendar.current.component(.second, from: currentDate)
        
        
        let timeData = ClockTimeData(withDate: currentDate)
        
        
        XCTAssertEqual(timeData.hours24, targetHours)
        XCTAssertEqual(timeData.minutes, targetMinutes)
        XCTAssertEqual(timeData.seconds, targetSeconds)
    }
    
    
    func testInitWithHoursMinutesAndSeconds_GoodInputs()
    {
        let inHours = 11
        let inMinutes = 59
        let inSeconds = 0
        
        
        let timeData = ClockTimeData(withHours: inHours, minutes: inMinutes, andSeconds: inSeconds)
        
        
        XCTAssertEqual(timeData.hours24, 11)
        XCTAssertEqual(timeData.minutes, 59)
        XCTAssertEqual(timeData.seconds, 0)
    }
    
    
    func testInitWithHoursMinutesAndSeconds_BadInputs()
    {
        let inHours = 24
        let inMinutes = 61
        let inSeconds = 78
        
        
        let timeData = ClockTimeData(withHours: inHours, minutes: inMinutes, andSeconds: inSeconds)
        
        
        XCTAssertEqual(timeData.hours24, 0)
        XCTAssertEqual(timeData.minutes, 1)
        XCTAssertEqual(timeData.seconds, 18)
    }
    
    
    func testHour24()
    {
        let inHours = 13
        
        let timeData = ClockTimeData(withHours: inHours, minutes: 0, andSeconds: 0)
        
        XCTAssertEqual(timeData.hours24, inHours)
    }
    
    
    func testHour12()
    {
        var timeData = ClockTimeData(withHours: 0, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.hours12, 12)
        
        timeData.updateTime(withHours: 1, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.hours12, 1)
        
        timeData.updateTime(withHours: 2, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.hours12, 2)
        
        timeData.updateTime(withHours: 3, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.hours12, 3)
        
        timeData.updateTime(withHours: 10, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.hours12, 10)
        
        timeData.updateTime(withHours: 11, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.hours12, 11)
        
        timeData.updateTime(withHours: 12, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.hours12, 12)
        
        timeData.updateTime(withHours: 13, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.hours12, 1)
        
        timeData.updateTime(withHours: 14, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.hours12, 2)
        
        timeData.updateTime(withHours: 15, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.hours12, 3)
        
        timeData.updateTime(withHours: 21, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.hours12, 9)
        
        timeData.updateTime(withHours: 22, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.hours12, 10)
        
        timeData.updateTime(withHours: 23, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.hours12, 11)
        
        timeData.updateTime(withHours: 24, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.hours12, 12)
    }
    
    
    func testAmOrPm()
    {
        var timeData = ClockTimeData(withHours: 0, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.amOrPm, .am)
        
        timeData.updateTime(withHours: 1, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.amOrPm, .am)
        
        timeData.updateTime(withHours: 2, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.amOrPm, .am)
        
        timeData.updateTime(withHours: 3, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.amOrPm, .am)
        
        timeData.updateTime(withHours: 10, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.amOrPm, .am)
        
        timeData.updateTime(withHours: 11, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.amOrPm, .am)
        
        timeData.updateTime(withHours: 12, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.amOrPm, .pm)
        
        timeData.updateTime(withHours: 13, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.amOrPm, .pm)
        
        timeData.updateTime(withHours: 14, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.amOrPm, .pm)
        
        timeData.updateTime(withHours: 15, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.amOrPm, .pm)
        
        timeData.updateTime(withHours: 21, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.amOrPm, .pm)
        
        timeData.updateTime(withHours: 22, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.amOrPm, .pm)
        
        timeData.updateTime(withHours: 23, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.amOrPm, .pm)
        
        timeData.updateTime(withHours: 24, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.amOrPm, .am)
    }
    
    
    func testHoursText24()
    {
        var timeData = ClockTimeData(withHours: 0, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.hoursText24, " 0")
        
        timeData.updateTime(withHours: 1, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.hoursText24, " 1")
        
        timeData.updateTime(withHours: 2, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.hoursText24, " 2")
        
        timeData.updateTime(withHours: 3, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.hoursText24, " 3")
        
        timeData.updateTime(withHours: 10, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.hoursText24, "10")
        
        timeData.updateTime(withHours: 11, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.hoursText24, "11")
        
        timeData.updateTime(withHours: 12, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.hoursText24, "12")
        
        timeData.updateTime(withHours: 13, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.hoursText24, "13")
        
        timeData.updateTime(withHours: 14, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.hoursText24, "14")
        
        timeData.updateTime(withHours: 15, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.hoursText24, "15")
        
        timeData.updateTime(withHours: 21, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.hoursText24, "21")
        
        timeData.updateTime(withHours: 22, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.hoursText24, "22")
        
        timeData.updateTime(withHours: 23, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.hoursText24, "23")
        
        timeData.updateTime(withHours: 24, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.hoursText24, " 0")
    }
    
    
    func testHoursText12()
    {
        var timeData = ClockTimeData(withHours: 0, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.hoursText12, "12")
        
        timeData.updateTime(withHours: 1, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.hoursText12, " 1")
        
        timeData.updateTime(withHours: 2, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.hoursText12, " 2")
        
        timeData.updateTime(withHours: 3, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.hoursText12, " 3")
        
        timeData.updateTime(withHours: 10, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.hoursText12, "10")
        
        timeData.updateTime(withHours: 11, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.hoursText12, "11")
        
        timeData.updateTime(withHours: 12, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.hoursText12, "12")
        
        timeData.updateTime(withHours: 13, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.hoursText12, " 1")
        
        timeData.updateTime(withHours: 14, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.hoursText12, " 2")
        
        timeData.updateTime(withHours: 15, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.hoursText12, " 3")
        
        timeData.updateTime(withHours: 21, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.hoursText12, " 9")
        
        timeData.updateTime(withHours: 22, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.hoursText12, "10")
        
        timeData.updateTime(withHours: 23, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.hoursText12, "11")
        
        timeData.updateTime(withHours: 24, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.hoursText12, "12")
    }
    
    
    func testAmOrPmText()
    {
        var timeData = ClockTimeData(withHours: 0, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.amOrPmText, "am")
        
        timeData.updateTime(withHours: 1, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.amOrPmText, "am")
        
        timeData.updateTime(withHours: 2, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.amOrPmText, "am")
        
        timeData.updateTime(withHours: 3, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.amOrPmText, "am")
        
        timeData.updateTime(withHours: 10, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.amOrPmText, "am")
        
        timeData.updateTime(withHours: 11, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.amOrPmText, "am")
        
        timeData.updateTime(withHours: 12, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.amOrPmText, "pm")
        
        timeData.updateTime(withHours: 13, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.amOrPmText, "pm")
        
        timeData.updateTime(withHours: 14, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.amOrPmText, "pm")
        
        timeData.updateTime(withHours: 15, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.amOrPmText, "pm")
        
        timeData.updateTime(withHours: 21, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.amOrPmText, "pm")
        
        timeData.updateTime(withHours: 22, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.amOrPmText, "pm")
        
        timeData.updateTime(withHours: 23, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.amOrPmText, "pm")
        
        timeData.updateTime(withHours: 24, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.amOrPmText, "am")
    }
    
    
    func testMinutesText()
    {
        var timeData = ClockTimeData(withHours: 0, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.minutesText, "00")
        
        timeData.updateTime(withHours: 0, minutes: 1, andSeconds: 0)
        XCTAssertEqual(timeData.minutesText, "01")
        
        timeData.updateTime(withHours: 0, minutes: 2, andSeconds: 0)
        XCTAssertEqual(timeData.minutesText, "02")
        
        timeData.updateTime(withHours: 0, minutes: 9, andSeconds: 0)
        XCTAssertEqual(timeData.minutesText, "09")
        
        timeData.updateTime(withHours: 0, minutes: 10, andSeconds: 0)
        XCTAssertEqual(timeData.minutesText, "10")
        
        timeData.updateTime(withHours: 0, minutes: 11, andSeconds: 0)
        XCTAssertEqual(timeData.minutesText, "11")
        
        timeData.updateTime(withHours: 0, minutes: 20, andSeconds: 0)
        XCTAssertEqual(timeData.minutesText, "20")
        
        timeData.updateTime(withHours: 0, minutes: 45, andSeconds: 0)
        XCTAssertEqual(timeData.minutesText, "45")
        
        timeData.updateTime(withHours: 0, minutes: 59, andSeconds: 0)
        XCTAssertEqual(timeData.minutesText, "59")
        
        timeData.updateTime(withHours: 0, minutes: 60, andSeconds: 0)
        XCTAssertEqual(timeData.minutesText, "00")
    }
    
    func testSecondsText()
    {
        var timeData = ClockTimeData(withHours: 0, minutes: 0, andSeconds: 0)
        XCTAssertEqual(timeData.secondsText, "00")
        
        timeData.updateTime(withHours: 0, minutes: 0, andSeconds: 1)
        XCTAssertEqual(timeData.secondsText, "01")
        
        timeData.updateTime(withHours: 0, minutes: 0, andSeconds: 2)
        XCTAssertEqual(timeData.secondsText, "02")
        
        timeData.updateTime(withHours: 0, minutes: 0, andSeconds: 9)
        XCTAssertEqual(timeData.secondsText, "09")
        
        timeData.updateTime(withHours: 0, minutes: 0, andSeconds: 10)
        XCTAssertEqual(timeData.secondsText, "10")
        
        timeData.updateTime(withHours: 0, minutes: 0, andSeconds: 11)
        XCTAssertEqual(timeData.secondsText, "11")
        
        timeData.updateTime(withHours: 0, minutes: 0, andSeconds: 20)
        XCTAssertEqual(timeData.secondsText, "20")
        
        timeData.updateTime(withHours: 0, minutes: 0, andSeconds: 45)
        XCTAssertEqual(timeData.secondsText, "45")
        
        timeData.updateTime(withHours: 0, minutes: 0, andSeconds: 59)
        XCTAssertEqual(timeData.secondsText, "59")
        
        timeData.updateTime(withHours: 0, minutes: 0, andSeconds: 60)
        XCTAssertEqual(timeData.secondsText, "00")
    }
    
    
    func testGreaterThanOperator()
    {
        // Left has more hours
        var leftTime = ClockTimeData(withHours: 9, minutes: 0, andSeconds: 0)
        var rightTime = ClockTimeData(withHours: 8, minutes: 0, andSeconds: 0)
        XCTAssertTrue(leftTime > rightTime)
        
        // Left has more minutes
        leftTime.updateTime(withHours: 3, minutes: 9, andSeconds: 0)
        rightTime.updateTime(withHours: 3, minutes: 8, andSeconds: 0)
        XCTAssertTrue(leftTime > rightTime)
        
        // Left has more seconds
        leftTime.updateTime(withHours: 3, minutes: 3, andSeconds: 9)
        rightTime.updateTime(withHours: 3, minutes: 3, andSeconds: 8)
        XCTAssertTrue(leftTime > rightTime)
        
        // Left has more hours and minutes
        leftTime.updateTime(withHours: 9, minutes: 4, andSeconds: 8)
        rightTime.updateTime(withHours: 3, minutes: 3, andSeconds: 8)
        XCTAssertTrue(leftTime > rightTime)
        
        // Left has more hours and seconds
        leftTime.updateTime(withHours: 9, minutes: 3, andSeconds: 9)
        rightTime.updateTime(withHours: 3, minutes: 3, andSeconds: 8)
        XCTAssertTrue(leftTime > rightTime)
        
        // Left has more minutes and seconds
        leftTime.updateTime(withHours: 3, minutes: 4, andSeconds: 9)
        rightTime.updateTime(withHours: 3, minutes: 3, andSeconds: 8)
        XCTAssertTrue(leftTime > rightTime)
        
        // Left has more of everything
        leftTime.updateTime(withHours: 5, minutes: 4, andSeconds: 9)
        rightTime.updateTime(withHours: 3, minutes: 3, andSeconds: 8)
        XCTAssertTrue(leftTime > rightTime)
        
        // Left is equal
        leftTime.updateTime(withHours: 9, minutes: 2, andSeconds: 2)
        rightTime.updateTime(withHours: 9, minutes: 2, andSeconds: 2)
        XCTAssertFalse(leftTime > rightTime)
        
        // Left has less seconds
        leftTime.updateTime(withHours: 5, minutes: 5, andSeconds: 2)
        rightTime.updateTime(withHours: 5, minutes: 5, andSeconds: 5)
        XCTAssertFalse(leftTime > rightTime)
        
        // Left has less minutes
        leftTime.updateTime(withHours: 5, minutes: 2, andSeconds: 5)
        rightTime.updateTime(withHours: 5, minutes: 5, andSeconds: 5)
        XCTAssertFalse(leftTime > rightTime)
        
        // Left has less hours
        leftTime.updateTime(withHours: 2, minutes: 5, andSeconds: 5)
        rightTime.updateTime(withHours: 5, minutes: 5, andSeconds: 5)
        XCTAssertFalse(leftTime > rightTime)
        
        // Left has less hours and minutes
        leftTime.updateTime(withHours: 2, minutes: 2, andSeconds: 5)
        rightTime.updateTime(withHours: 5, minutes: 5, andSeconds: 5)
        XCTAssertFalse(leftTime > rightTime)
        
        // Left has less hours and seconds
        leftTime.updateTime(withHours: 2, minutes: 5, andSeconds: 2)
        rightTime.updateTime(withHours: 5, minutes: 5, andSeconds: 5)
        XCTAssertFalse(leftTime > rightTime)
        
        // Left has less minutes and seconds
        leftTime.updateTime(withHours: 5, minutes: 2, andSeconds: 2)
        rightTime.updateTime(withHours: 5, minutes: 5, andSeconds: 5)
        XCTAssertFalse(leftTime > rightTime)
        
        // Left has less of everything
        leftTime.updateTime(withHours: 2, minutes: 2, andSeconds: 2)
        rightTime.updateTime(withHours: 5, minutes: 5, andSeconds: 5)
        XCTAssertFalse(leftTime > rightTime)
    }
    
    func testLessThanOrEqualToOperator()
    {
        // Left has more hours
        var leftTime = ClockTimeData(withHours: 9, minutes: 0, andSeconds: 0)
        var rightTime = ClockTimeData(withHours: 8, minutes: 0, andSeconds: 0)
        XCTAssertFalse(leftTime <= rightTime)
        
        // Left has more minutes
        leftTime.updateTime(withHours: 3, minutes: 9, andSeconds: 0)
        rightTime.updateTime(withHours: 3, minutes: 8, andSeconds: 0)
        XCTAssertFalse(leftTime <= rightTime)
        
        // Left has more seconds
        leftTime.updateTime(withHours: 3, minutes: 3, andSeconds: 9)
        rightTime.updateTime(withHours: 3, minutes: 3, andSeconds: 8)
        XCTAssertFalse(leftTime <= rightTime)
        
        // Left has more hours and minutes
        leftTime.updateTime(withHours: 9, minutes: 4, andSeconds: 8)
        rightTime.updateTime(withHours: 3, minutes: 3, andSeconds: 8)
        XCTAssertFalse(leftTime <= rightTime)
        
        // Left has more hours and seconds
        leftTime.updateTime(withHours: 9, minutes: 3, andSeconds: 9)
        rightTime.updateTime(withHours: 3, minutes: 3, andSeconds: 8)
        XCTAssertFalse(leftTime <= rightTime)
        
        // Left has more minutes and seconds
        leftTime.updateTime(withHours: 3, minutes: 4, andSeconds: 9)
        rightTime.updateTime(withHours: 3, minutes: 3, andSeconds: 8)
        XCTAssertFalse(leftTime <= rightTime)
        
        // Left has more of everything
        leftTime.updateTime(withHours: 5, minutes: 4, andSeconds: 9)
        rightTime.updateTime(withHours: 3, minutes: 3, andSeconds: 8)
        XCTAssertFalse(leftTime <= rightTime)
        
        // Left is equal
        leftTime.updateTime(withHours: 9, minutes: 2, andSeconds: 2)
        rightTime.updateTime(withHours: 9, minutes: 2, andSeconds: 2)
        XCTAssertTrue(leftTime <= rightTime)
        
        // Left has less seconds
        leftTime.updateTime(withHours: 5, minutes: 5, andSeconds: 2)
        rightTime.updateTime(withHours: 5, minutes: 5, andSeconds: 5)
        XCTAssertTrue(leftTime <= rightTime)
        
        // Left has less minutes
        leftTime.updateTime(withHours: 5, minutes: 2, andSeconds: 5)
        rightTime.updateTime(withHours: 5, minutes: 5, andSeconds: 5)
        XCTAssertTrue(leftTime <= rightTime)
        
        // Left has less hours
        leftTime.updateTime(withHours: 2, minutes: 5, andSeconds: 5)
        rightTime.updateTime(withHours: 5, minutes: 5, andSeconds: 5)
        XCTAssertTrue(leftTime <= rightTime)
        
        // Left has less hours and minutes
        leftTime.updateTime(withHours: 2, minutes: 2, andSeconds: 5)
        rightTime.updateTime(withHours: 5, minutes: 5, andSeconds: 5)
        XCTAssertTrue(leftTime <= rightTime)
        
        // Left has less hours and seconds
        leftTime.updateTime(withHours: 2, minutes: 5, andSeconds: 2)
        rightTime.updateTime(withHours: 5, minutes: 5, andSeconds: 5)
        XCTAssertTrue(leftTime <= rightTime)
        
        // Left has less minutes and seconds
        leftTime.updateTime(withHours: 5, minutes: 2, andSeconds: 2)
        rightTime.updateTime(withHours: 5, minutes: 5, andSeconds: 5)
        XCTAssertTrue(leftTime <= rightTime)
        
        // Left has less of everything
        leftTime.updateTime(withHours: 2, minutes: 2, andSeconds: 2)
        rightTime.updateTime(withHours: 5, minutes: 5, andSeconds: 5)
        XCTAssertTrue(leftTime <= rightTime)
    }
    
    
}
