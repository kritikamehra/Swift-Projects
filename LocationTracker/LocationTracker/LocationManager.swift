//
//  LocationManager.swift
//  LocationTracker
//
//  Created by Kritika Mehra on 25/09/25.
//

import CoreLocation
import MapKit
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.3349, longitude: -122.0090),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    @Published var pins: [LocationPin] = []
    
    private let pinsKey = "savedPins"
    
    override init() {
        super.init()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        loadPins()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        DispatchQueue.main.async {
            self.region.center = location.coordinate
        }
    }
    
    func addPin(at coordinate: CLLocationCoordinate2D) {
        DispatchQueue.main.async {
            let pin = LocationPin(coordinate: coordinate)
            self.pins.append(pin)
            self.savePins()
        }
    }
    
    private func savePins() {
        if let data = try? JSONEncoder().encode(pins) {
            UserDefaults.standard.set(data, forKey: pinsKey)
        }
    }
    
    private func loadPins() {
        if let data = UserDefaults.standard.data(forKey: pinsKey),
           let savedPins = try? JSONDecoder().decode([LocationPin].self, from: data) {
            DispatchQueue.main.async {
                self.pins = savedPins
            }
        }
    }
}
