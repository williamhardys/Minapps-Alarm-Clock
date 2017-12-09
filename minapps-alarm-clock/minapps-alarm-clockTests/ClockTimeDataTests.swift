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
    
    
    func testAmOrPM()
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
    
    
}
