//
//  NoteDetailView.swift
//  NotesApp
//
//  Created by Kritika Mehra on 14/09/25.
//

import SwiftUI

struct NoteDetailView: View {
    @Environment(\.managedObjectContext) var viewContext
    @State var editNote: Bool = false
    @ObservedObject var note: Note
    
    init(note: Note) {
           self.note = note
//           _title = State(initialValue: note.title ?? "")
//           _content = State(initialValue: note.content ?? "")
       }
       
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if editNote {
//                    NoteEditorFields(title: $note.title, content: $note.content)
                } else {
                    Text(note.title ?? "Untitled")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    if let date = note.timestamp {
                        Text(date.formatted(date: .abbreviated, time: .shortened))
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }
                    Divider()
                    
                    Text(note.content ?? "")
                        .font(.body)
                }
            }
            .padding()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing, content: {
                Button("Edit", systemImage: "pen") {
                    editNote = true
                }
            })
        }
        .navigationTitle("Note")
        .navigationBarTitleDisplayMode(.inline)
    }
}
