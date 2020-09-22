//
//  MatchHistoryList.swift
//  TopSpin
//
//  Created by Will Brandin on 9/21/20.
//

import SwiftUI

struct MatchHistoryList: View {

    var body: some View {
        List {
            ForEach(0..<10) { _ in
                NavigationLink(destination: Text("Destination")) {
                    MatchHistoryItem()
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
