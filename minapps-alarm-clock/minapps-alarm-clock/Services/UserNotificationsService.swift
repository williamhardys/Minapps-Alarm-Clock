//
//  UserNotificationsService.swift
//  minapps-alarm-clock
//
//  Created by Jibran Syed on 12/20/17.
//  Copyright © 2017 Jishenaz. All rights reserved.
//

import Foundation
import UserNotifications

class UserNotificationsService: NSObject
{
    static let instance = UserNotificationsService()
    private override init()
    {
    }
    
    
    let userNotificationCenter = UNUserNotificationCenter.current()
    
    
    func authorizeNotifications()
    {
        let options: UNAuthorizationOptions = [.alert, .sound]
        userNotificationCenter.requestAuthorization(options: options) { (isAuthorized, error) in
            debugPrint(error ?? "No error in authorizing notifcations :)")
            
            guard isAuthorized else {
                print("User did NOT authorize notifications")
                return
            }
            
            self.configureNotifications()
        }
    }
    
    
    func cancelScheduledNotifications(ofIdentifiers notifIDs: [String])
    {
        userNotificationCenter.removeDeliveredNotifications(withIdentifiers: notifIDs)
    }
    
    func cancelAllScheduledNotifications()
    {
        userNotificationCenter.removeAllPendingNotificationRequests()
    }
    
    
    func scheduleNotification(from request: UNNotificationRequest)
    {
        userNotificationCenter.add(request, withCompletionHandler: nil)
    }
    
    
    private func configureNotifications()
    {
        userNotificationCenter.delegate = self
    }
}


extension UserNotificationsService: UNUserNotificationCenterDelegate
{
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("UserNotif did receive response")
        
        completionHandler() // This must be called
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("UserNotif will present")
        
        let options: UNNotificationPresentationOptions = [.alert, .sound]
        completionHandler(options)  // This must be called
    }
}
