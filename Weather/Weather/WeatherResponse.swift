//
//  WeatherResponse.swift
//  Weather
//
//  Created by Kritika Mehra on 17/09/25.
//  Model

import Foundation

struct WeatherResponse: Codable {
    let name: String
    let weather: [Weather]
    let main: Main
    let wind: Wind
}

struct Weather: Codable {
    let main: String
    let description: String
}

struct Main: Codable {
    let temp: Double
    let feels_like: Double
    let humidity: Int
}

struct Wind: Codable {
    let speed: Double
}
