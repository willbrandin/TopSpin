//
//  MatchHistoryList.swift
//  TopSpin
//
//  Created by Will Brandin on 9/21/20.
//

import SwiftUI

struct MatchHistoryList: View {

    var body: some View {
        ScrollView {
            HistorySummaryView()
            
            LazyVStack(spacing: 0) {
                HStack {
                    Text("History")
                        .font(.caption)
                        .bold()
                        .foregroundColor(.secondary)
                    
                    Spacer()
                }
                .padding([.horizontal, .top])
                
                ForEach(0..<10) { _ in
                    NavigationLink(destination: MatchSummaryView()) {
                        MatchHistoryItem()
                            .contextMenu {
                                Label("Delete", systemImage: "trash")
                                Label("Share", systemImage: "square.and.arrow.up")
                            }
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.horizontal)
                    .padding(.vertical, 6)
                    
                }
            }
        }
        .navigationTitle("Match History")
    }
}

struct MatchHistoryList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MatchHistoryList()
        }
        .preferredColorScheme(.dark)
    }
}
