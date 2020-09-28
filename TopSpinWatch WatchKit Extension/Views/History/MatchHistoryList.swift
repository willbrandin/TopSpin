//
//  MatchHistoryList.swift
//  TopSpin
//
//  Created by Will Brandin on 9/21/20.
//

import SwiftUI

struct MatchHistoryList: View {
    
    @EnvironmentObject var store: AppStore

    var body: some View {
        if store.state.matchHistory.matches.isEmpty {
            Text("Start a Match for it to appear in Match History.")
                .font(.headline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                
        } else {
            List {
                ForEach(store.state.matchHistory.matches) { match in
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
            .preferredColorScheme(.dark)
        }
    }
}
