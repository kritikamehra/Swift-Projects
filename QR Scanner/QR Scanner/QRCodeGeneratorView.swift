//
//  QRCodeGeneratorView.swift
//  QR Scanner
//
//  Created by Kritika Mehra on 28/09/25.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct QRCodeGeneratorView: View {
    
    @State private var text: String = ""
    @State private var qrImage: UIImage?
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("Enter text to generate QR", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Generate QR") {
                qrImage = generateQRCode(from: text)
            }
            .padding()
            .buttonStyle(.borderedProminent)
            
            
            if let qrImage {
                Image(uiImage: qrImage)
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .padding()
            }
            
            Spacer()
        }
        .padding()
    }
    
    func generateQRCode(from text: String) -> UIImage? {
        let data = Data(text.utf8)
        filter.setValue(data, forKey: "inputMessage")

        if let outputImage = filter.outputImage, let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            return UIImage(cgImage: cgImage)
        }
        return nil
    }
}

#Preview {
    QRCodeGeneratorView()
}
