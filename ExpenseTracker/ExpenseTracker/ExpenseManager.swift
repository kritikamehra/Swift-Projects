//
//  ExpenseManager.swift
//  ExpenseTracker
//
//  Created by Kritika Mehra on 16/09/25.
//

import CoreData

struct ExpenseManager {
    static let shared = ExpenseManager()
    
    let container: NSPersistentContainer
    init() {
        container = NSPersistentContainer(name: "ExpenseModel")
        container.loadPersistentStores(completionHandler: { _,error in
            if let error = error {
                fatalError("Core Data error: \(error.localizedDescription)")
            }
        })
    }
}
