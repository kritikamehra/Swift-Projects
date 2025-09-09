//
//  ContentView.swift
//  ToDoApp
//
//  Created by Kritika Mehra on 08/09/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = TaskViewModel()
    @State private var newTask: Bool = false
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.tasks.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "square.and.pencil")
                            .font(.system(size: 50))
                            .foregroundColor(.gray)
                        Text("No tasks")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        Text("Tap + to add your first task")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                } else {
                    List{
                        Section(header: Text("Pending")) {
                            let pendingTasks = viewModel.tasks.filter { !$0.isCompleted }
                            
                            if pendingTasks.isEmpty {
                                HStack {
                                    Spacer()
                                    VStack(spacing: 8) {
                                        Image(systemName: "checkmark.seal.fill")
                                            .font(.system(size: 40))
                                            .foregroundColor(.green)
                                        Text("No pending tasks 🎉")
                                            .font(.headline)
                                            .foregroundColor(.secondary)
                                    }
                                    Spacer()
                                }
                                .padding(.vertical, 20)
                            } else{
                                ForEach(pendingTasks) { task in
                                    TaskRow(task: task, onToggle: { viewModel.toggle(task) },
                                            onDelete: { viewModel.delete(task)})
                                }
                            }
                        }
                        
                        Section(header: Text("Completed")) {
                            let completedTasks = viewModel.tasks.filter({ $0.isCompleted })
                            if completedTasks.isEmpty {
                                HStack {
                                           Spacer()
                                           VStack(spacing: 8) {
                                               Image(systemName: "hourglass")
                                                   .font(.system(size: 30))
                                                   .foregroundColor(.orange)
                                               Text("No completed tasks yet")
                                                   .font(.subheadline)
                                                   .foregroundColor(.secondary)
                                           }
                                           Spacer()
                                       }
                                       .padding(.vertical, 16)
                            }
                                else {
                                ForEach(completedTasks) { task in
                                    TaskRow(task: task, onToggle: { viewModel.toggle(task) },
                                            onDelete: { viewModel.delete(task) })
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("TO DO")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        newTask = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $newTask) {
                TaskFormView(onSave: { title, description in
                    viewModel.addTask(title: title, description: description)
                    newTask = false
                }, onCancel: {
                    newTask = false
                })
            }
        }
    }
}

#Preview {
    ContentView()
}
