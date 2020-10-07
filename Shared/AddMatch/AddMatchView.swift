//
//  AddMatchView.swift
//  TopSpin
//
//  Created by Will Brandin on 10/6/20.
//

import SwiftUI
import Combine

struct NumberTextField: View {
    var title: String
    var limit: Int?
    @Binding var text: String
    
    var body: some View {
        TextField(title, text: $text)
            .keyboardType(.numberPad)
            .onReceive(Just(text)) { newValue in
                let filtered = newValue.filter { "0123456789".contains($0) }
            
                if filtered != newValue || newValue.count > (limit ?? 0) {
                    self.text = filtered
                }
            }
    }
}

struct AddMatchView: View {
    
    @State private var playerScore: String = ""
    @State private var opponentScore: String = ""
    @State private var matchDate = Date()
    @State private var isInvalidScore = false
    
    @State private var calories = ""
    @State private var minHeartRate = ""
    @State private var maxHeartRate = ""
    @State private var avgHeartRate = ""
    
    @State private var endDate: Date = Date()
    
    @EnvironmentObject var store: AppStore
    @Environment(\.presentationMode) var presentationMode
    
    private let scoreDigitLimit = 2

    var body: some View {
        Form {
            Section {
                NumberTextField(title: "Your Score", limit: scoreDigitLimit, text: $playerScore)
                NumberTextField(title: "Opponent Score", limit: scoreDigitLimit, text: $opponentScore)
            }
            
            Section {
                DatePicker("Match Date", selection: $matchDate, displayedComponents: [.date, .hourAndMinute])
            }
            
            #if DEBUG
            Section(header: Text("Workout Information")) {
                NumberTextField(title: "Calories", limit: nil, text: $calories)
                NumberTextField(title: "Min Heart Rate", limit: nil, text: $minHeartRate)
                NumberTextField(title: "Max Heart Rate", limit: nil, text: $maxHeartRate)
                NumberTextField(title: "Avg Heart Rate", limit: nil, text: $avgHeartRate)
                DatePicker("End Date", selection: $endDate, displayedComponents: [.date, .hourAndMinute])
            }
            #endif
            
            Button("Save", action: save)
        }
        .alert(isPresented: $isInvalidScore) {
            Alert(title: Text("Please enter valid scores."))
        }
        .navigationTitle("Add Match")
    }
    
    private func save() {
        guard let playerScore = Int(playerScore), let opponentScore = Int(opponentScore) else {
            self.isInvalidScore = true
            return
        }
        
        var workout: Workout?
        if let cal = Int(calories), let avg = Int(avgHeartRate), let max = Int(maxHeartRate), let min = Int(minHeartRate) {
            workout = Workout(id: UUID(),
                                  activeCalories: cal,
                                  heartRateMetrics: WorkoutHeartMetric(averageHeartRate: avg, maxHeartRate: max, minHeartRate: min),
                                  startDate: matchDate,
                                  endDate: endDate)
        }
        
        let score = MatchScore(id: UUID(), playerScore: playerScore, opponentScore: opponentScore)
        let match = Match(id: UUID(), date: matchDate, score: score, workout: workout)
        
        store.send(.matchHistory(action: .add(match: match)))
        presentationMode.wrappedValue.dismiss()
    }
}

struct AddMatchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddMatchView()
        }
        .environmentObject(AppEnvironment.mockStore)

    }
}
