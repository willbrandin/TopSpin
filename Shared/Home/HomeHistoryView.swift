//
//  HomeHistoryView.swift
//  TopSpin
//
//  Created by Will Brandin on 9/25/20.
//

import SwiftUI

struct HomeHistoryView: View {
    
    @State private var isMatchCurrentlyActive = false
    
    var body: some View {
        ZStack {
            MatchHistoryContainer()
                .onTapGesture {
                    self.isMatchCurrentlyActive = !isMatchCurrentlyActive
                }
            
            VStack {
                Spacer()
                Button(action: {}) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Match Activated")
                                .font(.headline)
                                .bold()
                            Text("Tap to Open Match View")
                                .font(.subheadline)
                        }
                        Spacer()
                    }
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding()
                    .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 4)
                }
            }
            .offset(y: isMatchCurrentlyActive ? 0 : 200)
            .animation(.spring())
        }
    }
}

struct HomeHistoryView_Previews: PreviewProvider {
    
    static var previews: some View {
        TabView {
            NavigationView {
                HomeHistoryView()
            }
        }
        .environmentObject(AppEnvironment.mockStore)
    }
}
