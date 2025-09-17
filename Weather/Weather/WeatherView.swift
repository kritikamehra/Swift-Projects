//
//  WeatherView.swift
//  Weather
//
//  Created by Kritika Mehra on 17/09/25.
//

import SwiftUI

struct WeatherView: View {
    @State private var city: String = ""
    @State private var weather: WeatherResponse?
    @State private var isLoading = false
    @State private var errorMessage: String?
    
    let service = WeatherService()
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: backgroundColors(for: weather?.weather.first?.main ?? "Clear"),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    HStack{ TextField("Enter city name", text: $city)
                            .textFieldStyle(.roundedBorder)
//                            .padding()
                        //                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
                        //                        .padding(.horizontal)
                        
                        Button("Get Weather") {
                            Task {
                                do {
                                    let result = try await service.fetchWeather(for: city)
                                    weather = result
                                } catch {
                                    errorMessage = error.localizedDescription
                                }
                            }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    if let weather = weather {
                        Text("🌍 \(weather.name)")
                            .font(.largeTitle)
                            .bold()
                            .foregroundStyle(.white)
                        
                        Text("\(weather.main.temp, specifier: "%.1f")°C")
                            .font(.system(size: 50))
                            .foregroundStyle(.white)
                        
                        Text(weather.weather.first?.description.capitalized ?? "")
                            .font(.title3)
                            .foregroundStyle(.white.opacity(0.9))
                        
                        HStack {
                            Text("💧 Humidity: \(weather.main.humidity)%  • ")
                            Text("💨 Wind: \(weather.wind.speed, specifier: "%.1f") m/s")
                        }
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.9))
                        
                        Text("Feels like \(weather.main.feels_like, specifier: "%.1f")°C")
                            .font(.footnote)
                            .foregroundColor(.white.opacity(0.8))
                            .padding(.top, 5)
                    } else if isLoading {
                        ProgressView("Loading...")
                    } else if let errorMessage = errorMessage {
                        Text("Error: \(errorMessage)")
                            .foregroundColor(.red)
                    }
                }
                .padding()
                .task {
                    await loadWeather()
                }
                .navigationTitle("Weather")
            }
        }
    }
    
    func loadWeather() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let result = try await service.fetchWeather(for: "Delhi")
            weather = result
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    // MARK: - Gradient Helper
    func backgroundColors(for condition: String) -> [Color] {
        switch condition {
        case "Clear":
            // Bright blue → golden
            return [Color.blue, Color.orange]
        case "Clouds":
            // Dark gray → silver
            return [Color.gray.opacity(0.8), Color.white.opacity(0.6)]
        case "Rain":
            // Navy → gray
            return [Color.blue.opacity(0.9), Color.gray.opacity(0.8)]
        case "Snow":
            // Icy white → light blue
            return [Color.white, Color.cyan.opacity(0.7)]
        case "Thunderstorm":
            // Black → purple
            return [Color.black, Color.purple]
        case "Drizzle":
            // Teal → sky blue
            return [Color.teal, Color.blue.opacity(0.7)]
        case "Mist", "Fog":
            // Soft gray → white haze
            return [Color.gray.opacity(0.7), Color.white.opacity(0.8)]
        default:
            // Default = vivid blue
            return [Color.blue, Color.cyan]
        }
    }

    }

#Preview {
    WeatherView()
}
