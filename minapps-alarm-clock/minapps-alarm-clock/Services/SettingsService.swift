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
    static let instance = SettingsService()
    private init() 
    {
        // Register the settings bundle
        let appDefaults = [String:Any]()
        UserDefaults.standard.register(defaults: appDefaults)
    }
    
    
    
    func getColor() -> UIColor 
    {
        let chosenColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        
        return chosenColor
    }
    
    
}
