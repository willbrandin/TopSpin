//
//  ActiveMatchTabView.swift
//  TopSpinWatch WatchKit Extension
//
//  Created by Will Brandin on 9/24/20.
//

import SwiftUI

struct ActiveMatchTabContainer: View {
    @EnvironmentObject var store: AppStore
    
    @Binding var currentPage: Int
    
    var body: some View {
        ActiveMatchTabView(currentPage: $currentPage, cancel: cancel, complete: complete)
            .alert(isPresented: .constant(store.state.activeMatchState.teamDidWin), content: {
                let winningTeam = store.state.activeMatchState.winningTeam ?? .one
                let title = winningTeam == .one ? "You win!" : "Maybe next time!"
                let button: Alert.Button = .default(Text("Save Match"), action: complete)
                return Alert(title: Text(title), message: nil, dismissButton: button)
            })
    }
    
    func cancel() {
        print("MATCH CANCELLED")
        store.send(.workout(action: .end))
        store.send(.workout(action: .reset))
        store.send(.activeMatch(action: .cancel))
        currentPage = 2
    }
    
    func complete() {
        store.send(.workout(action: .end))
        store.send(.saveMatch)
        store.send(.activeMatch(action: .complete))
        store.send(.workout(action: .reset))
        print("MATCH COMPLETE")
        currentPage = 2
    }
}

struct ActiveMatchTabView: View {
    
    @Binding var currentPage: Int
    
    var cancel: () -> Void
    var complete: () -> Void
    
    var body: some View {
        TabView(selection: $currentPage) {
            MatchWorkoutContainerView(cancelAction: cancel)
                .tag(1)
            
            ActiveMatchView(completeAction: complete, cancelAction: cancel)
                .tag(2)
        }
    }
}

struct ActiveMatchTabView_Previews: PreviewProvider {

    static var previews: some View {
        StatefulPreviewWrapper(2) {
            ActiveMatchTabView(currentPage: $0, cancel: {}, complete: {})
                .environmentObject(AppEnvironment.mockStore)
        }
    }
}
