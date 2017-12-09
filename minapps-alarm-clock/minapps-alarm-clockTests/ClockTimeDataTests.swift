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
    
}
