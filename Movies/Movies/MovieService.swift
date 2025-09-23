//
//  MovieService.swift
//  Movies
//
//  Created by Kritika Mehra on 18/09/25.
//
import Foundation

class MovieService {
    private var apiKey = "84b8fee2"
    
    func fetchMovie(_ movie: String) async throws -> MovieResponse {
        let encodedTitle = movie.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? movie
        let urlString = "https://www.omdbapi.com/?t=\(encodedTitle)&apikey=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data,_) = try await URLSession.shared.data(from: url)
        let decodedData = try JSONDecoder().decode(MovieResponse.self, from: data)
        return decodedData
    }
}
