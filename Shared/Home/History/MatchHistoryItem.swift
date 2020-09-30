//
//  MatchHistoryItem.swift
//  TopSpin
//
//  Created by Will Brandin on 9/21/20.
//

import SwiftUI

struct MatchHistoryItem: View {

    var match: Match
    
    @Environment(\.colorScheme) var colorScheme

    var backgroundColor: UIColor {
        #if os(watchOS)
        return .clear
        #else
        return colorScheme == .dark ? .secondarySystemBackground : .systemBackground

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
        .shadow(color: Color.black.opacity(colorScheme == .dark ? 0 : 0.05), radius: 8, x: 0, y: 4)
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
