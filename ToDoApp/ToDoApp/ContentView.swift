//
//  ContentView.swift
//  ToDoApp
//
//  Created by Kritika Mehra on 08/09/25.
//

import SwiftUI

struct ContentView: View {
    @State var tasks: [Task] = TaskStore.shared.load()
    @State var newTask: Bool = false
    @State var taskTitle: String = ""
    @State var taskDescription: String = ""
    var body: some View {
        NavigationStack {
            VStack {
                if tasks.isEmpty {
                    Text("No tasks")
                } else {
                    List{
                        ForEach($tasks) { $task in
                            HStack {
//                                Toggle(isOn: $task.isCompleted) {
//                                    EmptyView()
//                                }
//                                .toggleStyle(.checkbox)
                                Image(systemName: $task.isCompleted.wrappedValue ? "checkmark.square.fill" : "square")
                                    .font(.title)
//                                    .foregroundColor(.green)
                                              .onTapGesture {
                                                  $task.isCompleted.wrappedValue.toggle()
                                              }
                                        
                                VStack {
                                    Text("\(task.title)")
                                    Text("\(task.description)")
                                        .foregroundColor(.gray)
                                        .lineLimit(1)
                                }
                            }
                            .swipeActions(edge: .trailing) {
                                Button("Delete", role: .destructive) {
                                    deleteTask(task)
                                }
                            }
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing, content: {
                    Button("", systemImage: "plus") {
                        newTask = true
                    }
                })
            }
            .sheet(isPresented: $newTask, content: {
                NavigationStack {
                    VStack(alignment: .leading) {
                        TextField("Task Title", text: $taskTitle)
                        TextField("Task Description", text: $taskDescription)
                        Spacer()
                    }
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                addNewTask()
                                newTask = false
                            }
                        }
                    }
                }
                .padding()
            })
            .navigationTitle("TO DO")
        }
    }
    
    func deleteTask(_ task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id}) {
            tasks.remove(at: index)
            saveTasks()
        }
    }
    
    func addNewTask() {
        let task = Task(title: taskTitle, description: taskDescription, isCompleted: false)
        tasks.append(task)
        saveTasks()
        taskTitle = ""
        taskDescription = ""
    }
    
    func saveTasks() {
        TaskStore.shared.save(tasks)
    }
}

#Preview {
    ContentView()
}
