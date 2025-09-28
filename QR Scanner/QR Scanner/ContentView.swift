//
//  ContentView.swift
//  QR Scanner
//
//  Created by Kritika Mehra on 28/09/25.
//

import SwiftUI

struct ContentView: View {
    @State private var scannedCode: String = "Not code yet"
    var body: some View {
     TabView {
         QRCodeGeneratorView()
             .tabItem {
                 Label("Generate QR", systemImage: "qrcode")
             }
         VStack {
             QRCodeScannerView(scannedCode: $scannedCode)
                 .edgesIgnoringSafeArea(.all)
                 .frame(height: 400)
             
             Text("Scanned code: ")
                 .font(.headline)
             Text(scannedCode)
                 .font(.subheadline)
                 .foregroundStyle(.blue)
                 .padding()
         }
         .tabItem {
             Label("Scan", systemImage: "camera.viewfinder")
         }
     }
    }
}

#Preview {
    ContentView()
}
