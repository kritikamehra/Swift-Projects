//
//  NotesManager.swift
//  NotesApp
//
//  Created by Kritika Mehra on 10/09/25.
//

import CoreData

class NotesManager {
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "NotesModel")
        container.loadPersistentStores {description, error in
            if let error = error {
                print("Core Data loading error: \(error.localizedDescription)")
            }
        }
    }
    
    var context : NSManagedObjectContext{
        container.viewContext
    }
}
