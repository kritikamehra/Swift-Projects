//
//  MealDetails.swift
//  RecipeFinder
//
//  Created by Kritika Mehra on 24/09/25.
//

import Foundation

struct MealDetails: Codable, Identifiable {
    let id: String
    let name: String
    let category: String?
    let area: String?
    let instructions: String?
    let thumbnail: String?
    
    let ingredient1: String?
    let ingredient2: String?
    let ingredient3: String?
    let ingredient4: String?
    let ingredient5: String?

    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case category = "strCategory"
        case area = "strArea"
        case instructions = "strInstructions"
        case thumbnail = "strMealThumb"
        case ingredient1 = "strIngredient1"
        case ingredient2 = "strIngredient2"
        case ingredient3 = "strIngredient3"
        case ingredient4 = "strIngredient4"
        case ingredient5 = "strIngredient5"
    }
    
    /// Helper to collect non-empty ingredients
    var ingredients: [String] {
        [ingredient1, ingredient2, ingredient3, ingredient4, ingredient5]
            .compactMap { $0 }
            .filter { !$0.isEmpty }
    }
}

struct MealDetailResponse: Codable {
    let meals: [MealDetails]?
}
