//
//  MatchHistoryScoreView.swift
//  TopSpin
//
//  Created by Will Brandin on 9/23/20.
//

import SwiftUI

struct MatchHistoryScoreView: View {
    
    var playerScore: Int
    var opponentScore: Int
    var date: String
    
    var body: some View {
        HStack(alignment: .top) {
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
            
            Spacer()
            
            Text(date.uppercased())
                .font(.subheadline)
                .foregroundColor(.secondary)
                .bold()
            
        }
        .minimumScaleFactor(0.7)
        .lineLimit(1)
        .layoutPriority(1)
    }
}


struct MatchHistoryScoreView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MatchHistoryScoreView(playerScore: 11, opponentScore: 8, date: "Sep 9")
                .previewLayout(.sizeThatFits)
                .padding()
            MatchHistoryScoreView(playerScore: 11, opponentScore: 8, date: "Sep 9")
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
                .padding()
        }
    }
}
