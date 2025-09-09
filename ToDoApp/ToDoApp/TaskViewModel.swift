//
//  TaskViewModel.swift
//  ToDoApp
//
//  Created by Kritika Mehra on 09/09/25.
//
import Foundation

@MainActor
class TaskViewModel: ObservableObject {
    @Published private(set) var tasks: [Task] = []
    private let store: TaskStore
    
    init(store: TaskStore = .shared) {
        self.store = TaskStore()
        self.tasks = store.load()
    }
    
    func addTask(title: String, description: String) {
        let task = Task(title: title, description: description, isCompleted: false)
        tasks.append(task)
        save()
    }
    
    func toggle(_ task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted = true
            save()
        }
    }
    
    func delete(_ task: Task) {
        tasks.removeAll(where: { $0.id == task.id})
        save()
    }
    
    func save() {
        store.save(tasks)
    }
}
