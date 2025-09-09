//
//  Task.swift
//  ToDoApp
//
//  Created by Kritika Mehra on 08/09/25.
//
import Foundation

struct Task: Identifiable, Codable {
    var id = UUID()
    var title: String
    var description: String
    var isCompleted: Bool
}
