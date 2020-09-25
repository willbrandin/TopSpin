//
//  MatchHistoryList.swift
//  TopSpin
//
//  Created by Will Brandin on 9/21/20.
//

import SwiftUI
import WatchConnectivity

struct MatchHistoryList: View {
    
    @Environment(\.colorScheme) var colorScheme
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
        Button("Add Match") {
        }
    }
    
    var isConnected: Bool {
        return WCSession.default.isWatchAppInstalled
    }
    
    var body: some View {
        VStack {
            if matchesStore.matches.isEmpty {
                VStack {
                    Text("Start a match on your wrist.\nWhen finished, it will display here.")
                        .font(.headline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    if !isConnected && WCSession.isSupported() {
                        if colorScheme == .light {
                            Button(action: openWatchAction) {
                                Text("Open Watch Settings")
                                    .bold()
                                    .padding()
                            }
                        } else {
                            Button(action: openWatchAction) {
                                Text("Open Watch Settings")
                                    .bold()
                                    .foregroundColor(.accentColor)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 48)
                                    .background(Color.clear)
                                    .contentShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                                    .cornerRadius(8)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.accentColor, lineWidth: 1)
                                    )
                                    .padding()
                            }
                        }
                    }
                }
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
    
    func openWatchAction() {
        UIApplication.shared.open(URL(string: "itms-watchs://com.willBrandin.dev")!) { (didOpen) in
            print(didOpen ? "Did open url" : "FAILED TO OPEN")
        }
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
