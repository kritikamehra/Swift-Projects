//
//  TaskStore.swift
//  ToDoApp
//
//  Created by Kritika Mehra on 09/09/25.
//

import Foundation
class TaskStore {
    static let shared = TaskStore()
    private let key = "tasks"
    
    func save(_ tasks: [Task]) {
        if let encoded = try? JSONEncoder().encode(tasks) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    
    func load() -> [Task] {
        if let data = UserDefaults.standard.data(forKey: key), let decoded = try? JSONDecoder().decode([Task].self, from: data) {
                return decoded
            }
        return []
    }
}
