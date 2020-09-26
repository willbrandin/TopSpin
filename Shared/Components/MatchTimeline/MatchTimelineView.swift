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
}

extension MatchScoredEvent {
    static let events = [
        MatchScoredEvent(playerScored: true),
        MatchScoredEvent(playerScored: true),
        MatchScoredEvent(playerScored: false),
        MatchScoredEvent(playerScored: false),
        MatchScoredEvent(playerScored: true),
        MatchScoredEvent(playerScored: true),
        MatchScoredEvent(playerScored: false),
        MatchScoredEvent(playerScored: true),
        MatchScoredEvent(playerScored: false),
        MatchScoredEvent(playerScored: true),
        MatchScoredEvent(playerScored: true),
        MatchScoredEvent(playerScored: false),
        MatchScoredEvent(playerScored: true),
        MatchScoredEvent(playerScored: true),
        MatchScoredEvent(playerScored: false),
        MatchScoredEvent(playerScored: true),
        MatchScoredEvent(playerScored: true)
    ]
}

struct MatchTimelineView: View {
    var events: [MatchScoredEvent]
    var body: some View {
        
        VStack(spacing: 8) {
            ForEach(events) { event in
                HStack {
                    Text(event.playerScored ? "You Scored" : "Opponent Scored")
                        .fontWeight(event.playerScored ? .bold : .none)
                        .frame(width: 150, alignment: .leading)
                    
                    Circle()
                        .frame(width: 10, height: 10)
                        .foregroundColor(event.playerScored ? .orange : .red)
                    Text("00:44")
                        .font(.caption)
                    Spacer()
                }
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
