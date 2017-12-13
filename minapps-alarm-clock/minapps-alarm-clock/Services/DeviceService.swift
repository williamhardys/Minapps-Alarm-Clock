//
//  DeviceService.swift
//  minapps-alarm-clock
//
//  Created by Jibran Syed on 12/13/17.
//  Copyright © 2017 Jishenaz. All rights reserved.
//

import UIKit

class DeviceService
{
    static let instance = DeviceService()
    private init()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(onBatteryStateChanged(_:)), name: .UIDeviceBatteryStateDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onSettingsChanged), name: UserDefaults.didChangeNotification, object: nil)
    }
    
    
    
    @objc 
    private func onBatteryStateChanged(_ notification: Notification)
    {
        self.determineAutolockState()
    }
    
    
    @objc
    private func onSettingsChanged()
    {
        self.determineAutolockState()
    }
    
    
    var batteryPercentage: Int
    {
        get
        {
            return Int(UIDevice.current.batteryLevel * 100.0)
        }
    }
    
    
    func determineAutolockState()
    {
        let isDevicePluggedIn = UIDevice.current.batteryState == .full || UIDevice.current.batteryState == .charging
        
        if isDevicePluggedIn
        {
            let autolockShouldBeEnabled = SettingsService.instance.willAutoLockWhenPluggedIn()
            
            if autolockShouldBeEnabled
            {
                UIApplication.shared.isIdleTimerDisabled = false
            }
            else // Disale autolock
            {
                UIApplication.shared.isIdleTimerDisabled = true
            }
        }
        else // Always enable autolock when unplugged
        {
            UIApplication.shared.isIdleTimerDisabled = false
        }
    }
    
}
