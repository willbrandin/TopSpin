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
        VStack {
            Text("Top Spin")
                .font(.headline)
            Text("🏓")
                .font(.title2)
                .padding(.bottom)
            
            Spacer()
            
            Button("Start Match") {
                self.matchActive = true
                self.pageIndex = 2
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
