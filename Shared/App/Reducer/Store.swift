//
//  Store.swift
//  TopSpin
//
//  Created by Will Brandin on 9/26/20.
//

import Foundation
import Combine

final class Store<State, Action>: ObservableObject {
    @Published private(set) var state: State

    private let reduce: (inout State, Action) -> AnyPublisher<Action, Never>
    private var effectCancellables: [UUID: AnyCancellable] = [:]
    private let queue: DispatchQueue

    init<Environment>(
        initialState: State,
        reducer: Reducer<State, Action, Environment>,
        environment: Environment,
        subscriptionQueue: DispatchQueue = .init(label: "com.aaplab.store")
    ) {
        self.queue = subscriptionQueue
        self.state = initialState
        self.reduce = { state, action in
            reducer(&state, action, environment)
        }
    }

    func send(_ action: Action) {
        let effect = reduce(&state, action)

        var didComplete = false
        let uuid = UUID()

        let cancellable = effect
            .subscribe(on: queue)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] _ in
                    didComplete = true
                    self?.effectCancellables[uuid] = nil
                },
                receiveValue: { [weak self] in self?.send($0) }
            )

        if !didComplete {
            effectCancellables[uuid] = cancellable
        }
    }

    func derived<DerivedState: Equatable, ExtractedAction>(deriveState: @escaping (State) -> DerivedState, embedAction: @escaping (ExtractedAction) -> Action) -> Store<DerivedState, ExtractedAction> {
        let store = Store<DerivedState, ExtractedAction>(
            initialState: deriveState(state),
            reducer: Reducer { _, action, _ in
                self.send(embedAction(action))
                return Empty().eraseToAnyPublisher()
            },
            environment: ()
        )

        $state
            .map(deriveState)
            .removeDuplicates()
            .assign(to: &store.$state)

        return store
    }
}
