//
//  Store.swift
//  TopSpin
//
//  Created by Will Brandin on 9/26/20.
//

import Foundation
import Combine
import os.log

struct Reducer<State, Action, Environment> {
    let reduce: (inout State, Action, Environment) -> AnyPublisher<Action, Never>

    func callAsFunction(_ state: inout State, _ action: Action, _ environment: Environment) -> AnyPublisher<Action, Never> {
        reduce(&state, action, environment)
    }

    func indexed<LiftedState, LiftedAction, LiftedEnvironment, Key>(
        keyPath: WritableKeyPath<LiftedState, [Key: State]>,
        extractAction: @escaping (LiftedAction) -> (Key, Action)?,
        embedAction: @escaping (Key, Action) -> LiftedAction,
        extractEnvironment: @escaping (LiftedEnvironment) -> Environment
    ) -> Reducer<LiftedState, LiftedAction, LiftedEnvironment> {
        .init { state, action, environment in
            guard let (index, action) = extractAction(action) else {
                return Empty(completeImmediately: true).eraseToAnyPublisher()
            }
            let environment = extractEnvironment(environment)
            return self.optional()
                .reduce(&state[keyPath: keyPath][index], action, environment)
                .map { embedAction(index, $0) }
                .eraseToAnyPublisher()
        }
    }

    func indexed<LiftedState, LiftedAction, LiftedEnvironment>(
        keyPath: WritableKeyPath<LiftedState, [State]>,
        extractAction: @escaping (LiftedAction) -> (Int, Action)?,
        embedAction: @escaping (Int, Action) -> LiftedAction,
        extractEnvironment: @escaping (LiftedEnvironment) -> Environment
    ) -> Reducer<LiftedState, LiftedAction, LiftedEnvironment> {
        .init { state, action, environment in
            guard let (index, action) = extractAction(action) else {
                return Empty(completeImmediately: true).eraseToAnyPublisher()
            }
            let environment = extractEnvironment(environment)
            return self.reduce(&state[keyPath: keyPath][index], action, environment)
                .map { embedAction(index, $0) }
                .eraseToAnyPublisher()
        }
    }

    func optional() -> Reducer<State?, Action, Environment> {
        .init { state, action, environment in
            if state != nil {
                return self(&state!, action, environment)
            } else {
                return Empty(completeImmediately: true).eraseToAnyPublisher()
            }
        }
    }

    func lift<LiftedState, LiftedAction, LiftedEnvironment>(
        keyPath: WritableKeyPath<LiftedState, State>,
        extractAction: @escaping (LiftedAction) -> Action?,
        embedAction: @escaping (Action) -> LiftedAction,
        extractEnvironment: @escaping (LiftedEnvironment) -> Environment
    ) -> Reducer<LiftedState, LiftedAction, LiftedEnvironment> {
        .init { state, action, environment in
            let environment = extractEnvironment(environment)
            guard let action = extractAction(action) else {
                return Empty(completeImmediately: true).eraseToAnyPublisher()
            }
            let effect = self(&state[keyPath: keyPath], action, environment)
            return effect.map(embedAction).eraseToAnyPublisher()
        }
    }

    static func combine(_ reducers: Reducer...) -> Reducer {
        .init { state, action, environment in
            let effects = reducers.compactMap { $0(&state, action, environment) }
            return Publishers.MergeMany(effects).eraseToAnyPublisher()
        }
    }
}

extension Reducer {
    func signpost(log: OSLog = OSLog(subsystem: "com.aaplab.food", category: "Reducer")) -> Reducer {
        .init { state, action, environment in
            os_signpost(.begin, log: log, name: "Action", "%s", String(reflecting: action))
            let effect = self.reduce(&state, action, environment)
            os_signpost(.end, log: log, name: "Action", "%s", String(reflecting: action))
            return effect
        }
    }

    func log(log: OSLog = OSLog(subsystem: "com.aaplab.food", category: "Reducer")) -> Reducer {
        .init { state, action, environment in
            os_log(.default, log: log, "Action %s", String(reflecting: action))
            let effect = self.reduce(&state, action, environment)
            os_log(.default, log: log, "State %s", String(reflecting: state))
            return effect
        }
    }
}

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
