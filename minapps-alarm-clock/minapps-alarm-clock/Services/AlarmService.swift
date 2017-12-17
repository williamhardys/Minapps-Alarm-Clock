//
//  AlarmService.swift
//  minapps-alarm-clock
//
//  Created by Jibran Syed on 12/13/17.
//  Copyright © 2017 Jishenaz. All rights reserved.
//

import Foundation
import CoreData


class AlarmService
{
    static let instance = AlarmService()
    private init()
    {
    }
    
    static let NOTIFICATION_ALARMS_UPDATED = Notification.Name("notif_alarms_updated")
    static let NOTIFICATION_ALARM_FIRED_OFF = Notification.Name("notif_alarm_fired_off")
    
    var alarms: [AlarmEntity_CoreData] = []
    private(set) public var nextAlarm: AlarmEntity_CoreData? = nil
    private var nextAlarmTimer: Timer? = nil
    
    
    // Used to load in AppDelegate
    func start()
    {
        self.loadAllAlarms { (success) in
            if success
            {
                //print("AlarmService loaded \(self.alarms.count) alarms successfully")
            }
            else
            {
                print("ERROR: AlarmService failed to load alarms")
            }
        }
        
        //self.determineNextAlarm()
    }
    
    
    func loadAllAlarms(onComplete: @escaping (_ success: Bool) -> Void)
    {
        CoreDataService.instance.loadEntities(ofType: AlarmEntity_CoreData.self) { (inAlarms) in
            guard let loadedAlarms = inAlarms else
            {
                print("ERROR: Alarms could not be loaded from Core Data")
                onComplete(false)
                return
            }
            
            self.alarms = loadedAlarms
            onComplete(true)
        }
    }
    
    
    func makeNewAlarmAndSave(onComplete: @escaping (_ newAlarm: AlarmEntity_CoreData?) -> Void)
    {
        let newAlarm = CoreDataService.instance.makeNewEntity(ofType: AlarmEntity_CoreData.self)
        
        CoreDataService.instance.saveAllEntities { (success) in
            if success
            {
                self.loadAllAlarms(onComplete: { (areAlarmsLoaded) in
                    if areAlarmsLoaded
                    {
                        onComplete(newAlarm)
                    }
                    else
                    {
                        print("Making a new alarm: failed to reload the list of alarms!")
                        onComplete(nil)
                    }
                })
            }
            else
            {
                CoreDataService.instance.deleteEntity(ofType: AlarmEntity_CoreData.self, entity: newAlarm)
                print("Making a new alarm: failed to save new alarm!")
                onComplete(nil)
            }
        }
    }
    
    
    func deleteAlarmAndSave(_ alarm: AlarmEntity_CoreData, onComplete: @escaping (_ success: Bool) -> Void)
    {
        CoreDataService.instance.deleteEntity(ofType: AlarmEntity_CoreData.self, entity: alarm)
        
        CoreDataService.instance.saveAllEntities { (success) in
            if success
            {
                self.loadAllAlarms(onComplete: { (areAlarmsLoaded) in
                    if areAlarmsLoaded
                    {
                        onComplete(true)
                    }
                    else
                    {
                        print("Delete an alarm: failed to reload the list of alarms!")
                        onComplete(false)
                    }
                })
            }
            else
            {
                print("Deleting an alarm: failed to delete alarm!")
                onComplete(false)
            }
        }
    }
    
    
    func determineNextAlarm()
    {
        self.cancelNextAlarm()
        
        // Find the alarm closest to the current time
        // TODO: Factor in the days of the week
        var closestTime: TimeInterval = 100_000.0
        //let dateNow = Date()
        //let currentWeekday = AlarmUtility.Weekday(rawValue: Calendar.current.component(.weekday, from: dateNow))!
        let timeNow = ClockTimeData(withDate:  Date())
        for alarm in self.alarms
        {
            // Skip if disabled
            if !alarm.alarmEnabled
            {
                continue
            }
            
            
            // Calculate the next time this alarm will trigger
            let timeAlarm = ClockTimeData(withHours: Int(alarm.timeHour24), minutes: Int(alarm.timeMinute), andSeconds: 0)
            let dateAlarm = ClockTimeDataUtility.makeFutureDateFrom(target: timeAlarm, with: timeNow)
            
            
            // Skip if not enabled for current weekday
            //       Does this alarm only repeat on some days and not others
            if !(AlarmUtility.doesAlarmRepeatEveryday(alarm) || AlarmUtility.doesAlarmRepeatNoDays(alarm))
            {
                // Skip if the alarm doesn't repeat on this weekday
                let alarmsWeekday = AlarmUtility.Weekday(rawValue: Calendar.current.component(.weekday, from: dateAlarm))!
                if !(AlarmUtility.doesAlarmRepeat(alarm, on: alarmsWeekday))
                {
                    continue
                }
            }
            
            
            // Check if this alarm is closer to triggering now than other alarms
            let timeRemaining = dateAlarm.timeIntervalSinceNow
            if timeRemaining < closestTime
            {
                closestTime = timeRemaining
                self.nextAlarm = alarm
                
                print("Closer alarm \"\(alarm.alarmName ?? "Unnamed Alarm")\" found:")
                print("   Date: \(dateAlarm.description(with: Locale.current))")
                print("   Seconds to Trigger: \(closestTime)")
            }
        }
        
        
        if self.nextAlarm != nil
        {
            // Schedule next alarm
            self.nextAlarmTimer = Timer.scheduledTimer(timeInterval: closestTime, target: self, selector: #selector(fireAlarm), userInfo: nil, repeats: false)
            NotificationCenter.default.post(name: AlarmService.NOTIFICATION_ALARMS_UPDATED, object: nil)
            
            print("Next alarm \"\(self.nextAlarm!.alarmName ?? "Unammed Alarm")\" scheduled in \(closestTime) seconds")
        }
        else
        {
            print("No alarms are scheduled X")
        }
    }
    
    
    func cancelNextAlarm()
    {
        if self.nextAlarm != nil && self.nextAlarmTimer != nil
        {
            print("Next alarm \"\(self.nextAlarm?.alarmName ?? "Unammed Alarm")\" cancelled")
            self.nextAlarmTimer!.invalidate()
            self.nextAlarmTimer = nil
            self.nextAlarm = nil
        }
    }
    
    
    @objc
    private func fireAlarm()
    {
        guard let currentAlarm = self.nextAlarm else {
            print("ERROR: Trying to trigger the next alarm, but it's nil!")
            return
        }
        
        print(">===========")
        print("    Alarm \"\(currentAlarm.alarmName ?? "NIL Alarm")\" was fired off!")
        print(">===========")
        
        // Disable this alarm if it has no repeats
        if AlarmUtility.doesAlarmRepeatNoDays(currentAlarm)
        {
            currentAlarm.alarmEnabled = false
            CoreDataService.instance.saveAllEntities(onComplete: { (success) in
                if success
                {
                    
                }
                else
                {
                    print("Failed to disable current alarm!")
                }
            })
        }
        
        NotificationCenter.default.post(name: AlarmService.NOTIFICATION_ALARM_FIRED_OFF, object: nil)
        
        self.determineNextAlarm()
    }
    
}
