//
//  MatchHistoryScoreView.swift
//  TopSpin
//
//  Created by Will Brandin on 9/23/20.
//

import SwiftUI

struct MatchHistoryScoreView: View {
    
    var playerScore: Int16
    var opponentScore: Int16
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(playerScore > opponentScore ? "WIN" : "LOSE")
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundColor(playerScore > opponentScore ? .green : .red)
            
            HStack {
                Text("\(playerScore)")
                    .bold()
                Text("-")
                    .bold()
                Text("\(opponentScore)")
                    .bold()
            }
            .font(.title)
            
        }
        .minimumScaleFactor(0.7)
        .lineLimit(1)
        .layoutPriority(1)
    }
}


struct MatchHistoryScoreView_Previews: PreviewProvider {
    static var previews: some View {
        MatchHistoryScoreView(playerScore: 11, opponentScore: 8)
    }
}
