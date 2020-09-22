//
//  MatchSetupView.swift
//  TopSpinWatch WatchKit Extension
//
//  Created by Will Brandin on 9/22/20.
//

import SwiftUI

struct MatchSetupView: View {
    
    @Binding var pageIndex: Int
    @Binding var matchActive: Bool
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Top Spin")
                    .font(.headline)
                Text("🏓")
                    .font(.title2)
                    .padding(.bottom)
                
                Spacer()
                
                NavigationLink(destination: MatchSettingsFormView()) {
                    HStack {
                        Text("Match Settings")
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                }
                
                Button("Start Match") {
                    self.matchActive = true
                    self.pageIndex = 2
                }
                
                VStack {
                    Text("Previous Match")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                    NavigationLink(destination: Text("Summary View")) {
                        MatchHistoryItem()
                    }
                }
                .padding(.top, 24)
            }
        }
    }
}

struct MatchSetupView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MatchSetupView(pageIndex: .constant(1), matchActive: .constant(false))
        }
    }
}
