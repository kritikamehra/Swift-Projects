//
//  MovieView.swift
//  Movies
//
//  Created by Kritika Mehra on 18/09/25.
//
import SwiftUI

struct MovieView: View {
    @State private var title: String = ""
    @State private var movie: MovieResponse?
    @State private var errorMessage: String?
    
    let service = MovieService()
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 20) {
                    HStack{ TextField("Enter movie name", text: $title)
                            .textFieldStyle(.roundedBorder)
                            .padding()
                        
                        Button("Search Movie") {
                            Task {
                                do {
                                    let result = try await service.fetchMovie(title)
                                    movie = result
                                    errorMessage = nil  // clear error if successful
                                } catch {
                                    errorMessage = "Failed to fetch movie: \(error.localizedDescription)"
                                    movie = nil
                                }
                            }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    Spacer()
                    if let movie = movie {
                        VStack {
                            Text(movie.Title)
                                .font(.title)
                                .bold()
                            
                            Text("Year: \(movie.Year)")
                                .foregroundColor(.secondary)
                            
                            Text("Genre: \(movie.Genre)")
                                .italic()
                            
                            if let url = URL(string: movie.Poster) {
                                AsyncImage(url: url) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView() // placeholder while loading
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .frame(maxHeight: 250)
                                            .cornerRadius(12)
                                    case .failure:
                                        Image(systemName: "film")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 100, height: 100)
                                            .foregroundColor(.gray)
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                            }
                            Text(movie.Plot)
                                .padding()
                                .multilineTextAlignment(.center)
                        }
                        .padding()
                    }
                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    }
                }
                .padding()
            }
            .navigationTitle("Movie Lookup")
        }
    }
}

#Preview {
    MovieView()
}
