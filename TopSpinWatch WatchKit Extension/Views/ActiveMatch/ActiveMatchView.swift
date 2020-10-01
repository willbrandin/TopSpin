//
//  ActiveMatchView.swift
//  TopSpinWatch WatchKit Extension
//
//  Created by Will Brandin on 9/22/20.
//

import SwiftUI

struct ActiveMatchView: View {
        
    @EnvironmentObject var store: AppStore
    
    var completeAction: () -> Void
    var cancelAction: () -> Void

    var matchController: ActiveMatchState {
        store.state.activeMatchState
    }
        
    var body: some View {
        ScrollView {
            VStack {
                if matchController.teamHasGamePoint {
                    Text("MATCH POINT")
                        .font(.caption2)
                        .bold()
                        .padding(2)
                        .background(Color.orange)
                        .cornerRadius(2)
                }
                
                HStack {
                    Spacer()
                    HStack {
                        HStack {
                            Circle()
                                .frame(width: 5, height: 5)
                                .foregroundColor(matchController.servingTeam == .one ? .green : .clear)
                            Text("\(matchController.teamOneScore)")
                        }
                        Text("-")
                        HStack {
                            Text("\(matchController.teamTwoScore)")
                            Circle()
                                .frame(width: 5, height: 5)
                                .foregroundColor(matchController.servingTeam == .two ? .green : .clear)
                        }
                    }
                    .font(.title)
                    Spacer()
                }
                
                Spacer()
                
                Button("Player 1") {
                    store.send(.activeMatch(action: .teamScored(team: .one)))
                }
                Button("Player 2") {
                    store.send(.activeMatch(action: .teamScored(team: .two)))
                }
                
                Button("Cancel", action: cancelAction)
                .buttonStyle(BorderedButtonStyle(tint: .red))
                .padding(.top, 24)
            }
        }
    }
}

struct ActiveMatchView_Previews: PreviewProvider {
    static var previews: some View {
        ActiveMatchView(completeAction: {}, cancelAction: {})
    }
}
