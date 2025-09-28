//
//  QRCodeScannerView.swift
//  QR Scanner
//
//  Created by Kritika Mehra on 28/09/25.
//

import SwiftUI
import VisionKit

struct QRCodeScannerView: View {
    @Binding var scannedCode: String
    @State private var isScannerAvailable: Bool = DataScannerViewController.isSupported
    var body: some View {
        VStack {
            if isScannerAvailable {
                ScannerView(scannedCode: $scannedCode)
                    .edgesIgnoringSafeArea(.all)
            } else {
                Text("Scanner not supported on this device")
                    .foregroundColor(.red)
            }
        }
    }
}
