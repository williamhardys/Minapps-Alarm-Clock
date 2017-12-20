//
//  AlarmService.swift
//  minapps-alarm-clock
//
//  Created by Jibran Syed on 12/13/17.
//  Copyright © 2017 Jishenaz. All rights reserved.
//

import Foundation
import CoreData
import UserNotifications


class AlarmService
{
    static let instance = AlarmService()
    private init()
    {
    }
    
    static let NOTIFICATION_ALARMS_UPDATED = Notification.Name("notif_alarms_updated")
    static let NOTIFICATION_ALARM_FIRED_OFF = Notification.Name("notif_alarm_fired_off")
    static let USER_NOTIF_ID = "userNotification.alarm"
    
    var alarms: [AlarmEntity_CoreData] = []
    private(set) public var nextAlarm: AlarmEntity_CoreData? = nil
    private var nextAlarmTimer: Timer? = nil
    private(set) public var snoozeMode = false
    private var snoozeDate = Date()
    private var dateAlarm = Date()
    
    
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
        
        let alarmTimeRemaining = self.calculateNextAlarmAndGetTimeRemaining()
        
        if self.nextAlarm != nil
        {            
            // Schedule next alarm
            self.nextAlarmTimer = Timer.scheduledTimer(timeInterval: alarmTimeRemaining, target: self, selector: #selector(fireAlarm), userInfo: nil, repeats: false)
            NotificationCenter.default.post(name: AlarmService.NOTIFICATION_ALARMS_UPDATED, object: nil)
            
            if self.snoozeMode
            {
                print("Alarm \"\(self.nextAlarm?.alarmName ?? "Unammed Alarm")\" snoozing for \(alarmTimeRemaining) seconds")
            }
            else
            {
                print("Next alarm \"\(self.nextAlarm?.alarmName ?? "Unammed Alarm")\" scheduled in \(alarmTimeRemaining) seconds")
            }
            
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
            if self.snoozeMode
            {
                print("Snooze for alarm \"\(self.nextAlarm?.alarmName ?? "Unammed Alarm")\" cancelled, for now...")
            }
            else
            {
                print("Next alarm \"\(self.nextAlarm?.alarmName ?? "Unammed Alarm")\" cancelled")
                self.nextAlarm = nil
            }
            
            self.nextAlarmTimer!.invalidate()
            self.nextAlarmTimer = nil
        }
    }
    
    
    func scheduleSnooze(forAlarm alarm: AlarmEntity_CoreData)
    {
        self.cancelNextAlarm()
        
        let snoozeSeconds = TimeInterval(alarm.snoozeDuration * 60.0)
        self.snoozeDate = Date()
        self.snoozeDate.addTimeInterval(snoozeSeconds)
        
        self.nextAlarm = alarm
        self.snoozeMode = true
        
        self.determineNextAlarm()
    }
    
    func cancelSnooze()
    {
        print("Snoozing for alarm \"\(self.nextAlarm?.alarmName ?? "Unnamed Alarm")\" ends")
        
        self.snoozeMode = false
        
        self.cancelNextAlarm()
        
        self.determineNextAlarm()
    }
    
    
    func pauseService()
    {
        self.cancelNextAlarm()
    }
    
    
    
    func scheduleAlarmNotification()
    {
        self.cancelAlarmNotification()
        
        let content = UNMutableNotificationContent()
        content.title = "\(self.nextAlarm?.alarmName ?? "Unnamed Alarm")"
        content.body = "This alarm is currently ringing"
        content.sound = UNNotificationSound(named: "\(self.nextAlarm?.soundName ?? "alarm_digital").wav")
        
        
        var components = DateComponents()
        components.year = Calendar.current.component(.year, from: self.dateAlarm)
        components.month = Calendar.current.component(.month, from: self.dateAlarm)
        components.day = Calendar.current.component(.day, from: self.dateAlarm)
        components.hour = Calendar.current.component(.hour, from: self.dateAlarm)
        components.minute = Calendar.current.component(.minute, from: self.dateAlarm)
        components.second = 0
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        
        let request = UNNotificationRequest(identifier: AlarmService.USER_NOTIF_ID, content: content, trigger: trigger)
        
        // Send notification
        UserNotificationsService.instance.scheduleNotification(from: request)
    }
    
    func cancelAlarmNotification()
    {
        UserNotificationsService.instance.cancelScheduledNotifications(ofIdentifiers: [AlarmService.USER_NOTIF_ID])
    }
    
    
    
    private func calculateNextAlarmAndGetTimeRemaining() -> TimeInterval
    {
        var closestTime: TimeInterval = Double.infinity
        
        if self.snoozeMode
        {
            closestTime = self.snoozeDate.timeIntervalSinceNow
        }
        else
        {
            // Find the alarm closest to the current time
            let timeNow = ClockTimeData(withDate: Date())
            for alarm in self.alarms
            {
                // Skip if disabled
                if !alarm.alarmEnabled
                {
                    continue
                }
                
                
                // Calculate the next time this alarm will trigger
                let timeAlarm = ClockTimeData(withHours: Int(alarm.timeHour24), minutes: Int(alarm.timeMinute), andSeconds: 0)
                dateAlarm = ClockTimeDataUtility.makeFutureDateFrom(target: timeAlarm, with: timeNow)
                
                
                // Skip if not enabled for current weekday
                //       Does this alarm only repeat on some days and not others
                if !(AlarmUtility.doesAlarmRepeatEveryday(alarm) || AlarmUtility.doesAlarmRepeatNoDays(alarm))
                {
                    // Skip if the alarm doesn't repeat on this weekday
                    let alarmsWeekday = AlarmUtility.Weekday(rawValue: Calendar.current.component(.weekday, from: dateAlarm))!
                    if !(AlarmUtility.doesAlarmRepeat(alarm, on: alarmsWeekday))
                    {
                        // Check the next closest day of the week for this alarm
                        let nextEnabledWeekday = self.getNextEnabledWeekday(forAlarm: alarm, startingFrom: alarmsWeekday)
                        
                        // Skip if there is no next weekday
                        if nextEnabledWeekday == nil
                        {
                            continue
                        }
                        
                        // Create a new date object for the next day of the week found
                        dateAlarm = ClockTimeDataUtility.makeDate(from: timeAlarm, forNextWeekday: nextEnabledWeekday!, startingFrom: alarmsWeekday, andTime: timeNow)
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
        }
        
        return closestTime
    }
    
    
    private func getNextEnabledWeekday(forAlarm alarm: AlarmEntity_CoreData, startingFrom initialWeekday: AlarmUtility.Weekday) -> AlarmUtility.Weekday?
    {
        let initialWeekdayCode = initialWeekday.rawValue
        var nextWeekday: AlarmUtility.Weekday? = nil
        
        for i in 1...6
        {
            var nextCode = initialWeekdayCode + i
            if nextCode != 7
            {
                nextCode %= 7
            }
            
            let currentWeekday = AlarmUtility.Weekday(rawValue: nextCode)!
            if AlarmUtility.doesAlarmRepeat(alarm, on: currentWeekday)
            {
                // Found the next enabled weekday
                nextWeekday = currentWeekday
                break
            }
            
        }
        
        return nextWeekday
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
        
        NotificationCenter.default.post(name: AlarmService.NOTIFICATION_ALARM_FIRED_OFF, object: nil, userInfo: ["Alarm":currentAlarm])
        
        self.cancelSnooze() // Also determines next alarm
    }
    
}
