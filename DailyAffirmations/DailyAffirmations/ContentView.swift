//
//  ContentView.swift
//  DailyAffirmations
//
//  Created by Kritika Mehra on 06/09/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var affirmations: [String] = [
        "I am worthy of success and happiness.",
        "I choose to focus on what I can control.",
        "I grow and improve every single day.",
        "I am grateful for the present moment.",
        "I trust myself and my decisions.",
        "Challenges help me grow stronger.",
        "I radiate positivity and attract good things.",
        "I am proud of how far I have come.",
        "I am enough just as I am.",
        "I believe in myself and my abilities.",
        "I let go of negativity and welcome peace.",
        "I have the power to create change.",
        "I am resilient, strong, and brave.",
        "I embrace learning and new experiences.",
        "I am surrounded by love and support."
    ]

    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.purple, .blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                List(affirmations, id:\.self) { affirmation in
                        HStack {
                            Image(systemName: "sun.max.fill")
                                .foregroundColor(.yellow)
                            Text("\(affirmation)")
                                .foregroundColor(.white)
                            
                    }
                        .listRowBackground(Color.clear)
                }
                .scrollContentBackground(.hidden)
                
            }
            .navigationTitle("Daily Affirmations")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    Button {
                        withAnimation {
                            affirmations.shuffle()
                        }
                    } label: {
                        Image(systemName: "arrow.clockwise.circle.fill")
                            .foregroundColor(.white)
                    }
                })
            }
        }
    }
}

#Preview {
    ContentView()
}
