//
//  CoreDataService.swift
//  minapps-alarm-clock
//
//  Created by Jibran Syed on 12/13/17.
//  Copyright © 2017 Jishenaz. All rights reserved.
//

import Foundation
import CoreData

class CoreDataService
{
    static let instance = CoreDataService()
    private init()
    {
        guard let moc = AppDelegate.coreDataManagedObjectContext else {
            debugPrint("CRITICAL!!!! Cannot find the Core Data Managed Object Context. Expect crashes soon!")
            _managedContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType) // Junk to prevent compiler errors
            return
        }
        
        _managedContext = moc
    }
    
    
    private var _managedContext: NSManagedObjectContext
    
    
    
    // Intentionally does nothing. Used to start private constructor in AppDeletgate
    func start()
    {
    }
    
    
    func loadEntities<T>(ofType entityType: T.Type, onComplete: @escaping (_ entities: [T]?) -> Void) where T : NSFetchRequestResult
    {
        let fetchRequest = NSFetchRequest<T>(entityName: "\(T.self)")
        
        var foundEntities: [T]? = nil
        
        do
        {
            foundEntities = try _managedContext.fetch(fetchRequest)
            print("Successfully fetched entites of type \(T.self)")
            onComplete(foundEntities)
        }
        catch
        {
            debugPrint("Could not fetch entites of type \(T.self): \(error.localizedDescription)")
            onComplete(nil)
        }
    }
    
    
    func saveAllEntities(onComplete: @escaping (_ success: Bool) -> Void)
    {
        // Only save if changes were detected
        if _managedContext.hasChanges
        {
            do 
            {
                try _managedContext.save()
                print("Core Data successfully saved all entities!")
                onComplete(true)
            }
            catch
            {
                debugPrint("Core Data could not save because: \(error.localizedDescription)")
                onComplete(false)
            }
        }
    }
    
    // Doesn't save. Must do manually
    func makeNewEntity<T>(ofType entityType: T.Type) -> T where T : NSManagedObject 
    {
        let newEntity = T(context: _managedContext)
        return newEntity
    }
    
    // Doesn't save. Must do manually
    func deleteEntity<T>(ofType entityType: T.Type, entity: T) where T : NSManagedObject
    {
        _managedContext.delete(entity)
    }
    
}
