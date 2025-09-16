//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Kritika Mehra on 16/09/25.
//

import SwiftUI
import CoreData
import Charts

struct ContentView: View {
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Expense.date, ascending: false)], animation: .default)
    private var expenses: FetchedResults<Expense>
    private var totalExpenses: Double {
           expenses.reduce(0) { $0 + $1.amount }
       }
    private var groupedExpenses: [(date: Date, total: Double)] {
          let grouped = Dictionary(grouping: expenses) { expense in
              Calendar.current.startOfDay(for: expense.date ?? Date())
          }
          return grouped.map { (date: $0.key, total: $0.value.reduce(0) { $0 + $1.amount }) }
              .sorted { $0.date < $1.date }
      }
    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack {
                        Text("Total Expenses")
                            .font(.headline)
                        Spacer()
                        Text("₹ \(totalExpenses, specifier: "%.2f")")
                            .font(.headline)
                            .foregroundColor(.blue)
                    }
                }

                Section("Expense Trend") {
                                 Chart(groupedExpenses, id: \.date) { item in
                                     BarMark(
                                         x: .value("Date", item.date, unit: .day),
                                         y: .value("Amount", item.total)
                                     )
                                     .foregroundStyle(.blue)
                                 }
                                 .frame(height: 200)
                             }
                             
                
                ForEach(expenses) { expense in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(expense.title ?? "Untitled")
                            .font(.headline)
                        Text("₹ \(expense.amount, specifier: "%.2f")")
                            .font(.subheadline)
                        Text(expense.date ?? Date(), style: .date)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                .onDelete(perform: deleteExpense)
            }
            .navigationTitle("Expenses")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AddNewExpenseView()) {
                        Label("Add", systemImage: "plus")
                    }
                }
            }
        }
    }
        private func deleteExpense(at offsets: IndexSet) {
                for index in offsets {
                    viewContext.delete(expenses[index])
                }
                try? viewContext.save()
            }
}

#Preview {
    ContentView()
}
