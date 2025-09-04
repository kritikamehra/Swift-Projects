//
//  ContentView.swift
//  BMICalculator
//
//  Created by Kritika Mehra on 02/09/25.
//

import SwiftUI

struct ContentView: View {
    @State private var userHeight: Double = 1.6  // default 1.6m
    @State private var userWeight: Double = 60.0 // default 60kg
        
    private var bmi: Double {
        guard userHeight > 0 else { return 0 }
        return userWeight / (userHeight * userHeight)
    }
    
    private var bmiCategory: (label: String, color: Color) {
        switch bmi {
        case ..<18.5:
            return ("Underweight", .blue)
        case ..<24.9:
            return ("Normal", .green)
        case ..<30:
            return ("Overweight", .orange)
        default:
            return ("Obese", .red)
        }
    }
    
    var body: some View {
        VStack(spacing: 25) {
            
            Text("BMI Calculator")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            VStack {
                Text("Height: \(String(format: "%.2f", userHeight)) m")
                Slider(value: $userHeight, in: 1...2.5, step: 0.02)
            }
            
            VStack {
                Text("Weight: \(String(format: "%.1f", userWeight)) kg")
                Slider(value: $userWeight, in: 20...150, step: 0.5)
            }
            
            VStack(spacing: 10) {
                Text("Your BMI \(String(format: "%.2f", bmi))")
                    .font(.title)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(bmiCategory.color.opacity(0.5))
                    )
                
                Text("\(bmiCategory.label)")
                    .font(.headline)
                    .foregroundColor(bmiCategory.color)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
