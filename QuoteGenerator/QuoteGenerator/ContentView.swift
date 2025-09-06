//
//  ContentView.swift
//  QuoteGenerator
//
//  Created by Kritika Mehra on 05/09/25.
//

import SwiftUI

struct ContentView: View {
    @State var quotes: [Quote] = []
    @State var isLoading = false
    
    var body: some View {
        VStack {
            if isLoading {
                ProgressView()
            } else {
                ForEach(quotes) { quote in
                    Text("\(quote.text)")
                        .multilineTextAlignment(.center)
                        .transition(.opacity)
                        .id(quote.id)
                }
            }
            
            Button("Get Quote") {
                Task {
                    do {
                        quotes = try await loadData()
                    } catch {
                        print(error)
                    }
                }
            }
            .padding()
            .buttonStyle(.bordered)
        }
        .animation(.easeInOut, value: quotes)
        .padding()
    }
    
    func loadData() async throws -> [Quote]{
        isLoading = true
        defer { isLoading = false }
        guard let url = URL(string: "https://zenquotes.io/api/random") else {
            throw NSError(domain: "MyAppError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
        }
       
        do {
            print("url \(url)")
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse,
                       (200...299).contains(httpResponse.statusCode) else {
                     throw NSError(domain: "MyAppError", code: 2,
                                   userInfo: [NSLocalizedDescriptionKey: "Bad server response"])
                 }
            
        let decodedData = try JSONDecoder().decode([Quote].self, from: data)
            return decodedData
        }
        catch {
            print("Decoding failed: \(error)")
            throw error
        }
        
       
    }
}

#Preview {
    ContentView()
}
