//
//  HistoryEmptyView.swift
//  TopSpin
//
//  Created by Will Brandin on 9/25/20.
//

import SwiftUI
import WatchConnectivity

struct HistoryEmptyView: View {
    
    @Environment(\.colorScheme) var colorScheme

    var isConnected: Bool {
        return WCSession.default.isWatchAppInstalled
    }
    
    var body: some View {
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
                            .padding(.horizontal)
                    }
                }
            }
        }
    }
    
    
    func openWatchAction() {
        UIApplication.shared.open(URL(string: "itms-watchs://com.willBrandin.dev")!) { (didOpen) in
            print(didOpen ? "Did open url" : "FAILED TO OPEN")
        }
    }
}

struct HistoryEmptyView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HistoryEmptyView()
            HistoryEmptyView()
                .preferredColorScheme(.dark)
        }
    }
}
