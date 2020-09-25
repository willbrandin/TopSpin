//
//  MatchHistoryItem.swift
//  TopSpin
//
//  Created by Will Brandin on 9/21/20.
//

import SwiftUI

struct MatchHistoryItem: View {

    var match: Match
    
    var backgroundColor: UIColor {
        #if os(watchOS)
        return .clear
        #else
        return .secondarySystemBackground
        #endif
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                HStack(alignment: .top) {
                    if let player = match.score?.playerScore,
                       let opponent = match.score?.opponentScore {
                        MatchHistoryScoreView(playerScore: player, opponentScore: opponent)
                    }
                    
                    Spacer()
                    
                    Text(match.shortDate.uppercased())
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .bold()
                }
                
                #if os(iOS)
                if let metric = WorkoutMetricContent(match: match) {
                    HistoryWorkoutMetricView(metricContent: metric)
                }
                #endif
            }
        }
        .padding()
        .background(Color(backgroundColor))
        .cornerRadius(8)
    }
}

struct MatchHistoryItem_Previews: PreviewProvider {
    
    static let context = PersistenceController.standardContainer.container.viewContext
    
    static var match: Match {
        let workout = Workout(context: context)
        workout.id = UUID()
        workout.activeCalories = 200
        workout.endDate = Date()
        workout.startDate = Date()
        workout.maxHeartRate = 146
        workout.minHeartRate = 112
        workout.averageHeartRate = 132
        
        let score = MatchScore(context: context)
        score.id = UUID()
        score.opponentScore = 7
        score.playerScore = 11
        
        let newItem = Match(context: context)
        newItem.workout = workout
        newItem.score = score
        newItem.date = Date()
        newItem.id = UUID()
        
        return newItem
    }
    
    static var previews: some View {
        Group {
            MatchHistoryItem(match: match)
                .padding()
                .preferredColorScheme(.dark)
        }
    }
}
