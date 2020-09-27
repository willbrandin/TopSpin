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
                MatchHistoryScoreView(playerScore: match.score.playerScore, opponentScore: match.score.opponentScore, date: match.shortDate)
                
                
                #if os(iOS)
                if let workout = match.workout {
                    HistoryWorkoutMetricView(metricContent: WorkoutMetricContent(workout: workout))
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
    
    static var previews: some View {
        Group {
            MatchHistoryItem(match: .mock)
                .previewLayout(.sizeThatFits)
                .padding()
                .preferredColorScheme(.dark)
            
            MatchHistoryItem(match: .mock)
                .previewLayout(.sizeThatFits)
                .padding()
        }
    }
}
