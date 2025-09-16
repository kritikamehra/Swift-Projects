//
//  ExpenseTrackerApp.swift
//  ExpenseTracker
//
//  Created by Kritika Mehra on 16/09/25.
//

import SwiftUI

@main
struct ExpenseTrackerApp: App {
    let expenseManager = ExpenseManager.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, expenseManager.container.viewContext)
        }
    }
}
