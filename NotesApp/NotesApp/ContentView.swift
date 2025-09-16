//
//  ContentView.swift
//  NotesApp
//
//  Created by Kritika Mehra on 10/09/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "timestamp", ascending: false)], animation: .default)
    private var notes: FetchedResults<Note>
    @State private var showingNeNote: Bool = false
    var body: some View {
        NavigationStack {
            List {
                ForEach(notes) { note in
                    NavigationLink(destination: NoteDetailView(note: note)) {
                        VStack(alignment: .leading) {
                            Text(note.title ?? "Untitled")
                                .font(.headline)
                            if let content = note.content, !content.isEmpty {
                                Text(content)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                    .lineLimit(1)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteNote)
      
            }
            .listStyle(.insetGrouped)
            .navigationTitle("My Notes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing){
                    Button {
                        showingNeNote = true
                    }label: {
                        Label("Add Note", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingNeNote, content: {
                NewNoteView()
            })
        }
    }
    
    func deleteNote(offsets: IndexSet) {
        offsets.map { notes[$0] }.forEach(viewContext.delete)
        try? viewContext.save()
    }
}

#Preview {
    ContentView()
}
