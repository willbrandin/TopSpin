//
//  MatchSummaryScoreView.swift
//  TopSpin
//
//  Created by Will Brandin on 9/25/20.
//

import SwiftUI

struct MatchSummaryScoreView: View {
    
    var score: String
    var didWin: Bool
    var date: String
    
    var content: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        HStack(spacing: 0) {
                            Text(score)
                                .bold()
                        }
                        .font(.largeTitle)
                        
                        Text(didWin ? "WIN" : "LOSE")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.green)
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(date)
                            .foregroundColor(.secondary)
                    }
                }
                
                Spacer()
            }
        }
    }
    
    var body: some View {
        #if os(watchOS)
        content
        #else
        content
            .padding()
        #endif
    }
}

struct MatchSummaryScoreView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MatchSummaryScoreView(score: "11-8", didWin: true, date: "11:12 AM - 11:41 AM")
                .previewLayout(.sizeThatFits)
            MatchSummaryScoreView(score: "7-11", didWin: false, date: "11:12 AM - 11:41 AM")
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
        }
    }
}
