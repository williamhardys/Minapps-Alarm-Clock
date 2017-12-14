//
//  AlarmListViewController.swift
//  minapps-alarm-clock
//
//  Created by Jibran Syed on 12/13/17.
//  Copyright © 2017 Jishenaz. All rights reserved.
//

import UIKit
import CoreData

class AlarmListViewController: UIViewController 
{
    static let STRYBRD_ID = "AlarmsListVC"
    
    @IBOutlet weak var tableAlarms: UITableView!
    
    
    override func viewDidLoad() 
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.tableAlarms.separatorColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.tableAlarms.reloadData()
    }
    
    
    func sendAlarmForEditing(_ alarm: AlarmEntity_CoreData)
    {
        // Create the ModifyAlarmVC
        guard let modifyAlarmVC = storyboard?.instantiateViewController(withIdentifier: ModifyAlarmViewController.STRYBRD_ID) as? ModifyAlarmViewController else {return}
        
        // Send the new alarm into to VC
        modifyAlarmVC.loadAlarm(alarm)
        
        // Load the VC
        present(modifyAlarmVC, animated: true, completion: nil)
    }
    
    
    
    @IBAction func onCloseBtnPressed(_ sender: Any) 
    {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func onNewAlarmBtnPressed(_ sender: Any) 
    {
        // Create a new alarm object
        var newAlarm: AlarmEntity_CoreData!
        AlarmService.instance.makeNewAlarmAndSave { (returnedAlarm) in
            guard let alarm = returnedAlarm else {print("Alarm creation failed!"); return}
            newAlarm = alarm
        }
        
        self.sendAlarmForEditing(newAlarm)
    }
    
    
    
    
    
}


extension AlarmListViewController: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int 
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int 
    {
        return AlarmService.instance.alarms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell 
    {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AlarmListCell.REUSE_ID) as? AlarmListCell else {return UITableViewCell()}
        
        let alarm = AlarmService.instance.alarms[indexPath.row]
        cell.setupCell(withAlarm: alarm)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) 
    {
        let alarm = AlarmService.instance.alarms[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: false)
        self.sendAlarmForEditing(alarm)
    }
    
}

