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
    
    var alarms: [AlarmEntity_CoreData] = []
    
    
    // Intentionally does nothing. Used to load in AppDelegate
    func start()
    {
        self.loadAllAlarms { (success) in
            if success
            {
                print("AlarmService loaded \(self.alarms.count) alarms successfully")
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
    
    
}
