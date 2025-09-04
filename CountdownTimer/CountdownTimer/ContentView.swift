//
//  ContentView.swift
//  CountdownTimer
//
//  Created by Kritika Mehra on 04/09/25.
//
import SwiftUI

struct ContentView: View {
    @State private var targetDate = Date().addingTimeInterval(10) // test with 10s later
    @State private var timeRemaining: Int = 0
    @State private var showAlert = false
    
    private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(spacing: 20) {
            DatePicker("Target Time", selection: $targetDate, displayedComponents: [.hourAndMinute])
                .datePickerStyle(.wheel)
                .labelsHidden()
                .padding()
            
            Text("⏳ \(formatTime(timeRemaining))")
                .font(.largeTitle)
                .bold()
                .monospacedDigit() // prevents digit from shifting
                .animation(.easeInOut(duration: 0.25), value: timeRemaining)
        }
        .onReceive(timer) { _ in
            let diff = Int(targetDate.timeIntervalSinceNow)
            let newValue = max(diff, 0) // to prevent negative values
            
            withAnimation {
                timeRemaining = newValue
            }
            
            if newValue == 0 {
                showAlert = true
            }
        }
        .alert("Time’s up!", isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        }
    }
    
    // Format seconds → HH:mm:ss
    func formatTime(_ seconds: Int) -> String {
        let hrs = seconds / 3600
        let mins = (seconds % 3600) / 60
        let secs = seconds % 60
        return String(format: "%02d:%02d:%02d", hrs, mins, secs)
    }
}
