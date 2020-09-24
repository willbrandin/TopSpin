//
//  MatchSetupView.swift
//  TopSpinWatch WatchKit Extension
//
//  Created by Will Brandin on 9/22/20.
//

import SwiftUI

struct MatchSetupView: View {
    
    var startAction: () -> Void
    
    var body: some View {
        VStack {
            Text("Top Spin")
                .font(.headline)
                .padding(.bottom)
            Text("🏓")
                .font(.title2)
                .padding(.bottom)
            
            Spacer()
            
            Button("Start Match", action: startAction)
        }
    }
}

struct MatchSetupView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MatchSetupView(startAction: { })
        }
    }
}
