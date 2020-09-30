//
//  MatchTimelineView.swift
//  TopSpin
//
//  Created by Will Brandin on 9/25/20.
//

import SwiftUI

struct MatchScoredEvent: Identifiable {
    let id = UUID()
    let playerScored: Bool
    let score: String
}

extension MatchScoredEvent {
    static let events = [
        MatchScoredEvent(playerScored: true, score: "1-0"),
        MatchScoredEvent(playerScored: true, score: "2-0"),
        MatchScoredEvent(playerScored: false, score: "2-1"),
        MatchScoredEvent(playerScored: false, score: "2-2"),
        MatchScoredEvent(playerScored: true, score: "3-2"),
        MatchScoredEvent(playerScored: true, score: "4-2"),
        MatchScoredEvent(playerScored: false, score: "4-3"),
        MatchScoredEvent(playerScored: true, score: "5-3"),
        MatchScoredEvent(playerScored: false, score: "5-4"),
        MatchScoredEvent(playerScored: true, score: "6-4"),
        MatchScoredEvent(playerScored: true, score: "7-4"),
        MatchScoredEvent(playerScored: false, score: "7-5"),
        MatchScoredEvent(playerScored: true, score: "8-5"),
        MatchScoredEvent(playerScored: true, score: "9-6"),
        MatchScoredEvent(playerScored: false, score: "9-5"),
        MatchScoredEvent(playerScored: true, score: "10-5"),
        MatchScoredEvent(playerScored: true, score: "11-5")
    ]
}

struct MatchTimelineView: View {
    var events: [MatchScoredEvent]
    var body: some View {
        
        VStack(spacing: 8) {
            HStack {
                Text("MATCH START")
                    .frame(width: 150, alignment: .leading)
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Spacer()
            }
            ForEach(events) { event in
                HStack {
                    Text(event.playerScored ? "You Scored" : "Opponent Scored")
                        .fontWeight(event.playerScored ? .bold : .none)
                        .frame(width: 150, alignment: .leading)
    
                    Text(event.score)
                        .font(.caption)
                        .bold()

                    Spacer()

                    Text("00:44")
                        .font(.caption)
                }
                .foregroundColor(event.playerScored ? .none : .secondary)

            }

            HStack {
                Text("MATCH FINISHED")
                    .frame(width: 150, alignment: .leading)
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Text(events.last!.score)
                    .font(.caption)
                    .bold()
                
                Spacer()

                Text("08:00")
                    .font(.caption)
            }
        }
    }
}

struct MatchTimelineView_Previews: PreviewProvider {
    
    static var previews: some View {
        MatchTimelineView(events: MatchScoredEvent.events)
            .previewLayout(.sizeThatFits)
    }
}
