//
//  MatchHistoryContainerView.swift
//  TopSpin
//
//  Created by Will Brandin on 9/22/20.
//

import SwiftUI

struct MatchHistoryContainerView: View {
    @FetchRequest(
        entity: Match.entity(),
        sortDescriptors: []
      ) var matches: FetchedResults<Match>
    
    var body: some View {
        List {
            ForEach(matches) { match in
                if let id = match.id {
                    Text("\(id)")
                }
            }
        }
    }
}

struct MatchHistoryContainerView_Previews: PreviewProvider {
    static var previews: some View {
        MatchHistoryContainerView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)

    }
}
