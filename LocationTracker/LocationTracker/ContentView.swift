//
//  ContentView.swift
//  LocationTracker
//
//  Created by Kritika Mehra on 25/09/25.
//

import SwiftUI
import MapKit
import CoreLocation

struct ContentView: View {
    @StateObject private var locationManager = LocationManager()
    var body: some View {
           ZStack {
               Map(coordinateRegion: $locationManager.region,
                   showsUserLocation: true,
                   annotationItems: locationManager.pins) { pin in
                   MapAnnotation(coordinate: pin.coordinate) {
                       Image(systemName: "mappin.circle.fill")
                           .foregroundColor(.red)
                           .font(.title)
                   }
               }
               .gesture(
                   LongPressGesture(minimumDuration: 0.5)
                       .onEnded { _ in
                           locationManager.addPin(at: locationManager.region.center)
                       }
               )
               .ignoresSafeArea()
               
               // Zoom controls
               VStack {
                   Spacer()
                   HStack {
                       Spacer()
                       VStack(spacing: 10) {
                           Button(action: { zoom(factor: 0.5) }) {
                               Image(systemName: "plus.magnifyingglass")
                                   .font(.title)
                                   .padding()
                                   .background(Color.white.opacity(0.8))
                                   .clipShape(Circle())
                           }
                           
                           Button(action: { zoom(factor: 2) }) {
                               Image(systemName: "minus.magnifyingglass")
                                   .font(.title)
                                   .padding()
                                   .background(Color.white.opacity(0.8))
                                   .clipShape(Circle())
                           }
                       }
                       .padding()
                   }
               }
           }
       }
       
       private func zoom(factor: Double) {
           var span = locationManager.region.span
           span.latitudeDelta *= factor
           span.longitudeDelta *= factor
           locationManager.region.span = span
       }

}

#Preview {
    ContentView()
}
