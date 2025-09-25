//
//  LocationPin.swift
//  LocationTracker
//
//  Created by Kritika Mehra on 25/09/25.
//

import CoreLocation

// MARK: - Model
struct LocationPin: Identifiable, Codable {
    let id: UUID
    let latitude: Double
    let longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    init(coordinate: CLLocationCoordinate2D) {
        self.id = UUID()
        self.latitude = coordinate.latitude
        self.longitude = coordinate.longitude
    }
}
