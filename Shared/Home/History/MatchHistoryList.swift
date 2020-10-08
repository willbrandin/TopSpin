//
//  MatchHistoryList.swift
//  TopSpin
//
//  Created by Will Brandin on 9/21/20.
//

import SwiftUI

struct MatchHistoryContainer: View {
    
    @EnvironmentObject var store: AppStore
    @State private var isAddMatchModalPresent: Bool = false

    var body: some View {
        MatchHistoryList(matches: store.state.matchHistory.matches, matchSummary: store.state.matchHistory.matchSummary, onDelete: self.delete)
            .sheet(isPresented: $isAddMatchModalPresent) {
                NavigationView {
                    AddMatchView()
                }
                .environmentObject(self.store)
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: { self.isAddMatchModalPresent = true }) {
                        Image(systemName: "plus")
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
    @Environment(\.horizontalSizeClass) var horizontalSize
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var matches: [Match]
    var matchSummary: [MatchSummary]
    var onDelete: (Match) -> Void
    
    var backgroundColor: Color {
        return colorScheme == .dark ? Color(UIColor.systemBackground) : Color(UIColor.secondarySystemBackground)
    }
    
    var verticalListView: some View {
        LazyVStack(spacing: 0) {
            ForEach(matches) { match in
                NavigationLink(destination: MatchSummaryView(match: match)) {
                    MatchHistoryItem(match: match)
                        .contextMenu {
                            Button(action: { self.onDelete(match) }){
                                Label("Delete", systemImage: "trash")
                            }
                        }
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.horizontal)
                .padding(.vertical, 6)
            }
        }
    }
    
    var verticalGridView: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(matches) { match in
                NavigationLink(destination: MatchSummaryView(match: match)) {
                    MatchHistoryItem(match: match)
                        .contextMenu {
                            Button(action: { self.onDelete(match) }){
                                Label("Delete", systemImage: "trash")
                            }
                        }
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.horizontal)
                .padding(.vertical, 6)
            }
        }
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
                
                if horizontalSize != .regular {
                    verticalListView
                } else {
                    verticalGridView
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
        MatchSummary(id: UUID(), monthRange: Date(), wins: 12, loses: 2, calories: 459, avgHeartRate: 145, matches: [.mockMatch(), .mockMatch(), .mockMatch(), .mockMatch(), .mockMatch()]),
        MatchSummary(id: UUID(), monthRange: Date(), wins: 22, loses: 4, calories: 688, avgHeartRate: 138, matches: [.mockMatch(), .mockMatch(), .mockMatch(), .mockMatch(), .mockMatch()]),
    ]
    
    static var previews: some View {
        Group {
            NavigationView {
                MatchHistoryList(matches: [.mockMatch(), .mockMatch(), .mockMatch(), .mockMatch(), .mockMatch()], matchSummary: list, onDelete: {_ in })
            }
            .preferredColorScheme(.dark)
            
            NavigationView {
                MatchHistoryList(matches: [.mockMatch(), .mockMatch(), .mockMatch(), .mockMatch(), .mockMatch()], matchSummary: list, onDelete: {_ in })
            }
        }
    }
}
