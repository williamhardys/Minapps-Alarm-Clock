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
        self.loadAllAlarms { (success) in
            if success
            {
                print("AlarmService loaded alarms successfully")
            }
            else
            {
                print("ERROR: AlarmService failed to load alarms")
            }
        }
    }
    
    var alarms: [AlarmEntity_CoreData] = []
    
    
    // Intentionally does nothing. Used to load in AppDelegate
    func start()
    {
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
    
}
