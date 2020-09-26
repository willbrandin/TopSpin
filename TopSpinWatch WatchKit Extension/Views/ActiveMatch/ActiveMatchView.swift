//
//  ActiveMatchView.swift
//  TopSpinWatch WatchKit Extension
//
//  Created by Will Brandin on 9/22/20.
//

import SwiftUI

struct ActiveMatchView: View {
    
    var completeAction: () -> Void
    var cancelAction: () -> Void
    
    @EnvironmentObject var workoutSession: WorkoutManager
    @EnvironmentObject var matchController: RallyMatchController
    
    fileprivate let id = UUID()
    
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
                    matchController.incrementScore(for: .one)
                }
                Button("Player 2") {
                    matchController.incrementScore(for: .two)
                }
                
                Button("Cancel", action: cancelAction)
                .buttonStyle(BorderedButtonStyle(tint: .red))
                .padding(.top, 24)
                
            }
            .alert(isPresented: $matchController.teamDidWin) {
                workoutSession.pauseWorkout()
                let winningTeam = matchController.winningTeam
                let title = winningTeam == .one ? "You win!" : "Maybe next time!"
                let button: Alert.Button = .default(Text("Save Match"), action: completeAction)
                return Alert(title: Text(title), message: nil, dismissButton: button)
            }
        }
    }
}

struct ActiveMatchView_Previews: PreviewProvider {
    static var previews: some View {
        ActiveMatchView(completeAction: {}, cancelAction: {})
    }
}
