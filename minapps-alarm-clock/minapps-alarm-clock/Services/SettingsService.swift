//
//  SettingsService.swift
//  minapps-alarm-clock
//
//  Created by Jibran Syed on 12/11/17.
//  Copyright © 2017 Jishenaz. All rights reserved.
//

import UIKit

class SettingsService
{
    let KEY_COLOR = "settings_color"
    let KEY_FONT = "settings_font"
    let KEY_USE_24_HOUR = "settings_use_24_hour_mode"
    let KEY_SHOW_SEC = "settings_show_seconds"
    let KEY_SHOW_DATE = "settings_show_date"
    let KEY_SHOW_BATT = "settings_show_battery"
    let KEY_BRIGHTNESS = "settings_brightness_level"
    let KEY_ENABLE_SWIPE_BRIGHTNESS = "settings_enable_brightness_swipe"
    let KEY_AUTOLOCK_PLUGGED_IN = "settings_enable_lock_plugged_in"
    
    
    static let instance = SettingsService()
    private init() 
    {
        // Register the settings bundle
        let appDefaults = [String:Any]()
        UserDefaults.standard.register(defaults: appDefaults)
    }
    
    
    private var _settingsData = UserDefaults.standard
    
    
    
    func isUsing24HourConvention() -> Bool 
    {
        return _settingsData.bool(forKey: KEY_USE_24_HOUR)
    }
    
    func doesShowSeconds() -> Bool
    {
        return _settingsData.bool(forKey: KEY_SHOW_SEC)
    }
    
    func doesShowDate() -> Bool 
    {
        return _settingsData.bool(forKey: KEY_SHOW_DATE)
    }
    
    func doesShowBattery() -> Bool
    {
        return _settingsData.bool(forKey: KEY_SHOW_BATT)
    }
    
    
    func getBrightnessRatio() -> CGFloat
    {
        return CGFloat(_settingsData.float(forKey: KEY_BRIGHTNESS))
    }
    
    func setBrightnessRatio(_ value: CGFloat)
    {
        var newValue : CGFloat = 0.0
        
        // Clamp
        if value > 1.0
        {
            newValue = 1.0
        }
        else if value < 0.0
        {
            newValue = 0.0
        }
        else
        {
            newValue = value
        }
        
        _settingsData.set(newValue, forKey: KEY_BRIGHTNESS)
    }
    
    func canSwipeToControllBrightness() -> Bool
    {
        return _settingsData.bool(forKey: KEY_ENABLE_SWIPE_BRIGHTNESS)
    }
    
    
    func getColor() -> UIColor 
    {
        var chosenColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        
        let colorCode = _settingsData.integer(forKey: KEY_COLOR)
        
        switch colorCode
        {
        case 0: // Red
            chosenColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
            break
        case 1: // Orange
            chosenColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            break
        case 2: // Yellow
            chosenColor = #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
            break
        case 3: // Green
            chosenColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
            break
        case 4: // Blue
            chosenColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
            break
        case 5: // Purple
            chosenColor = #colorLiteral(red: 0.5791940689, green: 0.1280144453, blue: 0.5726861358, alpha: 1)
            break
        default:
            print("SETTINGS ERROR: Invalid Color Code!!! Will default to red color.")
        }
        
        return chosenColor
    }
    
    
}
