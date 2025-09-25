//
//  MealService.swift
//  RecipeFinder
//
//  Created by Kritika Mehra on 24/09/25.
//
import Foundation

struct MealService {
    func fetchMeals(_ ingredient: String) async throws -> MealResponse {
        let urlString = "https://www.themealdb.com/api/json/v1/1/filter.php?i=\(ingredient)"
        guard let url = URL(string: urlString) else {
            print("URL not found")
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decodedData = try JSONDecoder().decode(MealResponse.self, from: data)
        return decodedData
    }
    
    func lookMealDetail(by id: String) async throws -> MealDetails? {
        let urlString = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(id)"
        
        guard let url = URL(string: urlString) else {
            print("URL not found")
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decodedData = try JSONDecoder().decode(MealDetailResponse.self, from: data)
        return decodedData.meals?.first
    }
}
