//
//  NotesAppApp.swift
//  NotesApp
//
//  Created by Kritika Mehra on 10/09/25.
//

import SwiftUI

@main
struct NotesAppApp: App {
    let notesManager = NotesManager()
        
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, notesManager.context)
        }
    }
}
