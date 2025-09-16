//
//  NotesEditorFields.swift
//  NotesApp
//
//  Created by Kritika Mehra on 15/09/25.
//
import SwiftUI

struct NoteEditorFields: View {
    @Binding var title: String
    @Binding var content: String
    
    var body: some View {
        VStack(spacing: 16) {
            TextField("Title", text: $title)
                .font(.title2)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
            
            TextEditor(text: $content)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .frame(minHeight: 200)
        }
    }
}
