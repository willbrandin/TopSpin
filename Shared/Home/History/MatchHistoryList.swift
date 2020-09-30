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
        MatchHistoryList(matches: store.state.matchHistory.matches, onDelete: self.delete)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("FAKE") {
                        store.send(.matchHistory(action: .add(match: .mock_nonWorkout_Match())))
                    }
                }
            }
    }
    
    func delete(_ match: Match) {
        store.send(.matchHistory(action: .delete(match: match)))
    }
}

struct MatchHistoryList: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var matches: [Match]
    var onDelete: (Match) -> Void
    
    var backgroundColor: Color {
        return colorScheme == .dark ? Color(UIColor.systemBackground) : Color(UIColor.secondarySystemBackground)
    }
    
    var historyListView: some View {
        ZStack {
            backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
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
    
    static var previews: some View {
        Group {
            NavigationView {
                MatchHistoryList(matches: [.mock], onDelete: {_ in })
            }
            .preferredColorScheme(.dark)
            
            NavigationView {
                MatchHistoryList(matches: [.mock], onDelete: {_ in })
            }
        }
    }
}
