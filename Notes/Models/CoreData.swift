//
//  CoreData.swift
//  Notes
//
//  Created by Christopher Smith on 11/12/17.
//  Copyright © 2017 Christopher Smith. All rights reserved.
//

import Foundation
import CoreData

class CoreData {
    
    // MARK: - Core Data stack
    
    // Prevents initializing this CoreData instance outside of this class.
    private init() {}
    
    static let context = CoreData.persistentContainer.viewContext
    
    static var persistentContainer: NSPersistentContainer {
        
        let container = NSPersistentContainer(name: "Notes")
        
        container.loadPersistentStores(completionHandler: { storeDescription, error in
            
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        return container
    }
    
    // MARK: - Core Data Saving support
    
    static func saveContext() {
        
        if self.context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

