//
//  MatchSummaryScoreView.swift
//  TopSpin
//
//  Created by Will Brandin on 9/25/20.
//

import SwiftUI

struct MatchSummaryScoreView: View {
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        HStack {
                            Text("11")
                                .bold()
                            Text("-")
                                .bold()
                            Text("8")
                                .bold()
                        }
                        .font(.largeTitle)
                        
                        Text("WIN")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.green)
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("11:12 AM - 11:41 AM")
                            .foregroundColor(.secondary)
                    }
                }
                
                Spacer()
            }
            .padding()
        }
    }
}

struct MatchSummaryScoreView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MatchSummaryScoreView()
                .previewLayout(.sizeThatFits)
            MatchSummaryScoreView()
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
        }
    }
}
