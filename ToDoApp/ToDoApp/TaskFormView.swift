//
//  T.swift
//  ToDoApp
//
//  Created by Kritika Mehra on 09/09/25.
//
import SwiftUI

struct TaskFormView: View {
    @State private var title: String = ""
    @State private var description: String = ""
    
    let onSave: (String, String) -> Void
    let onCancel: () -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Details")){
                    TextField("Task Title", text: $title)
                    TextField("Task Description", text: $description, axis: .vertical)
                        .lineLimit(1...5)
                }
            }
            .navigationTitle("New Task")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        onSave(title, description)
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { onCancel() }
                }
            }
        }
    }
}
