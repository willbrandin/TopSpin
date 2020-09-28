//
//  MatchHistoryList.swift
//  TopSpin
//
//  Created by Will Brandin on 9/21/20.
//

import SwiftUI

struct MatchHistoryList: View {
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var store: AppStore

    var historyListView: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(store.state.matchHistory.matches) { match in
                    MatchHistoryItem(match: match)
                        .contextMenu {
                            Button(action: { self.delete(match) }){
                                Label("Delete", systemImage: "trash")
                            }
                            
                            Button(action: {}) {
                                Label("Share", systemImage: "square.and.arrow.up")
                            }
                        }
                    .padding(.horizontal)
                    .padding(.vertical, 6)
                }
            }
        }
    }
    
    var body: some View {
        VStack {
            if store.state.matchHistory.matches.isEmpty {
                HistoryEmptyView()
            } else {
                historyListView
            }
        }
        .navigationTitle("Match History")
    }
    
    func delete(_ match: Match) {
        store.send(.matchHistory(action: .delete(match: match)))
    }
}

struct MatchHistoryList_Previews: PreviewProvider {
    static let matchStorage = MatchStorage(managedObjectContext: PersistenceController.standardContainer.container.viewContext)

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
        .environmentObject(matchStorage)
    }
}
