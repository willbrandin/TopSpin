//
//  MatchHistoryList.swift
//  TopSpin
//
//  Created by Will Brandin on 9/21/20.
//

import SwiftUI

struct MatchHistoryList: View {
    
    @EnvironmentObject var matchesStore: MatchStorage

    var body: some View {
        if matchesStore.matches.isEmpty {
            Text("Start a Match for it to appear in Match History.")
                .font(.headline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                
        } else {
            List {
                ForEach(matchesStore.matches) { match in
                    MatchHistoryItem(match: match)
                }
            }
            .navigationTitle("Match History")
        }
    }
}

struct MatchHistoryList_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                MatchHistoryList()
            }
            .environmentObject(MatchStorage(managedObjectContext: PersistenceController.standardContainer.container.viewContext))
            .preferredColorScheme(.dark)
        }
    }
}
