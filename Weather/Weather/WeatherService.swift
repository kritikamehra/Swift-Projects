//
//  WeatherService.swift
//  Weather
//
//  Created by Kritika Mehra on 17/09/25.
//  Networking Service

import Foundation

class WeatherService {
    private let apiKey = "1f7b8faf23de59b1f86e7e9c2740d755"
    
    func fetchWeather (for city: String) async throws -> WeatherResponse {
        let cityEncoded = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? city
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(cityEncoded)&appid=\(apiKey)&units=metric"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data,_) = try await URLSession.shared.data(from: url)
        let dataDecoded = try JSONDecoder().decode(WeatherResponse.self, from: data)
        return dataDecoded
    }
}
