//
//  AlarmListViewController.swift
//  minapps-alarm-clock
//
//  Created by Jibran Syed on 12/13/17.
//  Copyright © 2017 Jishenaz. All rights reserved.
//

import UIKit

class AlarmListViewController: UIViewController 
{
    static let STRYBRD_ID = "AlarmsListVC"

    override func viewDidLoad() 
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    
    
    @IBAction func onCloseBtnPressed(_ sender: Any) 
    {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func onNewAlarmBtnPressed(_ sender: Any) 
    {
        
    }
    

}
