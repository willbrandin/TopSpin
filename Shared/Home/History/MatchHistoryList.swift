//
//  MatchHistoryList.swift
//  TopSpin
//
//  Created by Will Brandin on 9/21/20.
//

import SwiftUI

struct MatchHistoryContainer: View {
    @EnvironmentObject var store: AppStore
    
    var body: some View {
        MatchHistoryList(matches: store.state.matchHistory.matches, matchSummary: store.state.matchHistory.matchSummary, onDelete: self.delete)
    }
    
    func delete(_ match: Match) {
        store.send(.matchHistory(action: .delete(match: match)))
    }
}

struct MatchHistoryList: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var matches: [Match]
    var matchSummary: [MatchSummary]
    var onDelete: (Match) -> Void
    
    var backgroundColor: Color {
        return colorScheme == .dark ? Color(UIColor.systemBackground) : Color(UIColor.secondarySystemBackground)
    }
    
    var historyListView: some View {
        ZStack {
            backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                
                if !matchSummary.isEmpty {
                    HorizontalSummaryView(historySummary: matchSummary)
                    
                    HStack {
                        Text("Match History")
                            .padding(.horizontal)
                        Spacer()
                    }
                }
                
                LazyVStack(spacing: 0) {
                    ForEach(matches) { match in
                        NavigationLink(destination: MatchSummaryView(match: match)) {
                            MatchHistoryItem(match: match)
                                .contextMenu {
                                    Button(action: { self.onDelete(match) }){
                                        Label("Delete", systemImage: "trash")
                                    }
                                    
                                    Button(action: {}) {
                                        Label("Share", systemImage: "square.and.arrow.up")
                                    }
                                }
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.horizontal)
                        .padding(.vertical, 6)
                    }
                }
            }
        }
    }
    
    var body: some View {
        VStack {
            if matches.isEmpty {
                HistoryEmptyView()
            } else {
                historyListView
            }
        }
        .navigationTitle("Match History")
    }
    
}

struct MatchHistoryList_Previews: PreviewProvider {
    
    static let list = [
        MatchSummary(dateRange: "SEP 2020", wins: 12, loses: 2, calories: 459, avgHeartRate: 145),
        MatchSummary(dateRange: "AUG 2020", wins: 22, loses: 4, calories: 688, avgHeartRate: 138),
    ]
    
    static var previews: some View {
        Group {
            NavigationView {
                MatchHistoryList(matches: [.mock], matchSummary: list, onDelete: {_ in })
            }
            .preferredColorScheme(.dark)
            
            NavigationView {
                MatchHistoryList(matches: [.mock], matchSummary: list, onDelete: {_ in })
            }
        }
    }
}
