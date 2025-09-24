//
//  Meal.swift
//  RecipeFinder
//
//  Created by Kritika Mehra on 24/09/25.
//
import Foundation

struct Meal: Codable, Identifiable {
    let mealName: String
    let mealThumbnail: String
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case mealName = "strMeal"
        case mealThumbnail = "strMealThumb"
        case id = "idMeal"
    }
}

struct MealResponse: Codable {
    let meals: [Meal]?
}
