//
//  ContentView.swift
//  UnitConverter
//
//  Created by Kritika Mehra on 03/09/25.
//

import SwiftUI

struct ContentView: View {
    @State var input: String = ""
    @State var inputUnit: UnitLength = .meters
    @State var outputUnit: UnitLength = .kilometers
    
    var units: [UnitLength] = [.meters, .kilometers, .feet]
    
    var output: Double? {
        guard let value = Double(input) else { return nil }
        let inputMeasurement = Measurement(value: value, unit: inputUnit)
        return inputMeasurement.converted(to: outputUnit).value
        
    }
    
    var body: some View {
        NavigationView{
            Form {
                Section("Input") {
                    HStack { Text("Input: ")
                        TextField("value", text: $input)
                        .keyboardType(.decimalPad)}
                    Picker("Unit", selection: $inputUnit, content: {
                        ForEach(units, id:\.self) { unit in
                            Text("\(unit.symbol)")
                        }
                    })
                }
                Section(header: Text("Output")) {
                    Picker("Unit", selection: $outputUnit, content: {
                        ForEach(units, id:\.self) { unit in
                            Text("\(unit.symbol)")
                        }
                    })
                    
                    if let result = output {
                        Text("\(String(format: "%.4f", result)) \(outputUnit.symbol)")
                            .bold()
                    }
                    else {
                        Text("Enter a valid number")
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("Unit Converter")
        }
    }
}

#Preview {
    ContentView()
}
