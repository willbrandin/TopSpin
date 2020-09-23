//
//  MatchHistoryList.swift
//  TopSpin
//
//  Created by Will Brandin on 9/21/20.
//

import SwiftUI

struct MatchHistoryList: View {
    
    @ObservedObject var matchesStore: MatchStorage

    var historyListView: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(matchesStore.matches) { match in
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
    
    var devMockAddButton: some View {
        Button("ADD FAKE") {
            matchesStore.addNew()
        }
    }
    
    var body: some View {
        VStack {
            if matchesStore.matches.isEmpty {
                Text("Start a match on your wrist.\nWhen finished, it will display here.")
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            } else {
                historyListView
            }
        }
        .navigationTitle("Match History")
        .navigationBarItems(trailing: devMockAddButton)
    }
    
    func delete(_ match: Match) {
        matchesStore.delete([match])
    }
}

struct MatchHistoryList_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                MatchHistoryList(matchesStore: MatchStorage(managedObjectContext: PersistenceController.standardContainer.container.viewContext))
            }
            .preferredColorScheme(.dark)
            
            NavigationView {
                MatchHistoryList(matchesStore: MatchStorage(managedObjectContext: PersistenceController.standardContainer.container.viewContext))
            }
        }
    }
}
