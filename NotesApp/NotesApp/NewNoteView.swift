//
//  NewNoteView.swift
//  NotesApp
//
//  Created by Kritika Mehra on 11/09/25.
//

import SwiftUI

struct NewNoteView: View {
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.dismiss) var dismiss
    var editNoteView: Bool = false
    @State private var title: String = ""
    @State private var content: String = ""
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 12) {
//                TextField("Title", text: $title)
//                    .textFieldStyle(.roundedBorder)
//                    .padding(.horizontal)
//                
//                Text("Content")
//                    .font(.headline)
//                    .padding(.horizontal)
//                
//                TextEditor(text: $description)
//                    .padding()
//                    .background(Color(.systemGray6))
//                    .cornerRadius(6)
//                    .frame(minHeight: 20)
//
                NoteEditorFields(title: $title, content: $content)
                Spacer()
            }
            .navigationTitle("New Note")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        addNote()
                        dismiss()
                    }
                    .disabled(title.isEmpty && description.isEmpty)
                }
            }
        }
    }
    func addNote() {
        let newNote = Note(context: viewContext)
        newNote.id = UUID()
        newNote.title = title
        newNote.content = description
        newNote.timestamp = Date()
        try?viewContext.save()
    }
    
}
