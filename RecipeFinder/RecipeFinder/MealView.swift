//
//  MealView.swift
//  RecipeFinder
//
//  Created by Kritika Mehra on 24/09/25.
//

import SwiftUI

struct MealView: View {
    @State var ingredient: String = ""
    @State var mealResponse: MealResponse?
    @State var errorMessage: String?
    let services = MealService()
    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                HStack {
                    TextField("Enter main ingredient", text: $ingredient)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button("Search recipes") {
                        Task {
                            do {
                                let result = try await services.fetchMeals(ingredient)
                                mealResponse = result
                                errorMessage = nil
                            } catch {
                                errorMessage = "Failed to fetch meals"
                                mealResponse = nil
                            }
                        }
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding()
                
                Spacer()
                
                if let mealResponse = mealResponse {
                    if let mealList = mealResponse.meals {
                        
                            List(mealList) { meal in                                NavigationLink(destination: MealDetailView(mealId: meal.id)) {
                                    VStack{
                                        AsyncImage(url: URL(string: meal.mealThumbnail)) { image in
                                            image.resizable().scaledToFill()
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        .frame(width: .infinity, height: 200)
                                        .clipShape(RoundedRectangle(cornerRadius:  8))
                                        Text(meal.mealName)
                                            .font(.headline)
                                    }
                                }
                            }
                        }
                    
                }
            }
            .navigationTitle("Recipe Finder")
        }
    }
}

#Preview {
    MealView()
}
