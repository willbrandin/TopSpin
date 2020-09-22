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
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 8) {
                    ForEach(0..<6) { _ in
                        HistorySummaryView()
                            .contextMenu {
                                Button(action: {}) {
                                    Label("Share", systemImage: "square.and.arrow.up")
                                }
                            }
                    }
                }
                .padding(.horizontal)
            }
            
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
//                    NavigationLink(destination: MatchSummaryView()) {
                    MatchHistoryItem()
                        .contextMenu {
                            Button(action: {}){
                                Label("Delete", systemImage: "trash")
                            }
                            
                            Button(action: {}) {
                                Label("Share", systemImage: "square.and.arrow.up")
                            }
                        }
//                    }
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
        Group {
            NavigationView {
                MatchHistoryList()
            }
            .preferredColorScheme(.dark)
            NavigationView {
                MatchHistoryList()
            }
        }
    }
}
