//
//  ContentView.swift
//  TipCalculator
//
//  Created by Kritika Mehra on 25/08/25.
//

import SwiftUI

struct ContentView: View {
    @State var billAmount: Int = 0
    var tips = [10, 15, 20, 25, 30]
    @State var tipPercentage: Int = 0
    @State var total = 0
    var body: some View {
        VStack {
            HStack {
                Text("Bill Amount")
                TextField("Enter Bill Amount", value: $billAmount, format: .number)
            }
            HStack {
                Text("Tip Percentage: ")
                Spacer()
                Text("\(tipPercentage)%")
                VStack{
                    Picker("Tip Percentage: ", selection: $tipPercentage) {
                        ForEach(tips, id: \.self) { option in
                            Text("\(option)")
                        }
                    }
//                    .pickerStyle(.menu)
                    .labelsHidden()
                    .onChange(of: tipPercentage) {
                        calculateTip()
                    }
                }
            }
            Text("Total Bill: \(total)")
                .font(.title)
//                .numberFormatter(.currency)

        }
        .padding()
    }
    
    func calculateTip() {
        total = billAmount + (billAmount*tipPercentage/100)
    }
    
    
}

#Preview {
    ContentView()
}
