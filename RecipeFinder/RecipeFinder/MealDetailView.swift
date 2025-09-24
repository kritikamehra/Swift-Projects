//
//  MealDetailView.swift
//  RecipeFinder
//
//  Created by Kritika Mehra on 24/09/25.
//

import SwiftUI
 
struct MealDetailView: View {
    let mealId: String
    @State private var meal: MealDetails?
    let service = MealService()
    var body: some View {
        ScrollView {
               if let meal = meal {
                   VStack(alignment: .leading, spacing: 16) {
//                       AsyncImage(url: URL(string: meal.thumbnail ?? "")) { image in
//                           image.resizable().scaledToFit()
//                       } placeholder: {
//                           ProgressView()
//                       }
//                       .frame(maxWidth: .infinity)
                       
                       Text(meal.name)
                           .font(.largeTitle)
                           .bold()
                       
                       if let category = meal.category {
                           Text("Category: \(category)")
                               .font(.subheadline)
                       }
                       if let area = meal.area {
                           Text("Area: \(area)")
                               .font(.subheadline)
                       }
                       
                       Divider()
                       
                       Text("Ingredients")
                           .font(.headline)
                       ForEach(meal.ingredients, id: \.self) { ingredient in
                           Text("• \(ingredient)")
                       }
                       
                       Divider()
                       
                       Text("Instructions")
                           .font(.headline)
                       Text(meal.instructions ?? "No instructions available.")
                   }
                   .padding()
               } else {
                   ProgressView("Loading...")
               }
           }
           .task {
               do {
                   meal = try await service.lookMealDetail(by: mealId)
               } catch {
                   print("Error: \(error)")
               }
           }
    }
}
