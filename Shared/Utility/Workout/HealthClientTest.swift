import Foundation
import ComposableArchitecture
import Combine
import HealthKit

struct HealthClient {
    var requestAuthorization: (Set<HKSampleType>?, Set<HKObjectType>?) -> Effect<Bool, Error>
    var startActivity: (HKWorkoutConfiguration, Date) -> Effect<Bool, Error>
//    var beginCollection: (Date) -> Effect<Bool, Never>
    
    var pause: () -> Effect<Never, Never>
    var resume: () -> Effect<Never, Never>
    var end: () -> Effect<Never, Never>
    
    var sessionDelegate: Effect<SessionDelegateEvent, Never>
    var builderDelegate: Effect<BuilderDelegateEvent, Never>
    
    enum SessionDelegateEvent {
        case workoutSession(workoutSession: HKWorkoutSession, toState: HKWorkoutSessionState,
                            fromState: HKWorkoutSessionState, date: Date)
        case workoutSession(workoutSession: HKWorkoutSession, didFailtWithError: Error)
        case workoutSession(workoutSession: HKWorkoutSession, didGenerate: HKWorkoutEvent)
    }
    
    enum BuilderDelegateEvent {
        case workoutBuilderDidCollectEvent(workoutBuilder: HKLiveWorkoutBuilder)
        case workoutBuilder(workoutBuilder: HKLiveWorkoutBuilder, didCollectDataOf: Set<HKSampleType>)
    }
}

extension HealthClient {
    static var live: Self {
        let healthStore = HKHealthStore()
        var session: HKWorkoutSession!
        var builder: HKLiveWorkoutBuilder!
        
        return Self(
            requestAuthorization: { share, read in
                .future { callback in
                    healthStore.requestAuthorization(toShare: share, read: read) { granted, error in
                        if let error = error {
                            callback(.failure(error))
                        } else {
                            callback(.success(granted))
                        }
                    }
                }
            },
            startActivity: { configuration, date in
                session = try! HKWorkoutSession(healthStore: healthStore, configuration: configuration)
                builder = session.associatedWorkoutBuilder()

                builder.dataSource = HKLiveWorkoutDataSource(healthStore: healthStore, workoutConfiguration: configuration)
                session.startActivity(with: date)
                
                return .future { callback in
                    builder.beginCollection(withStart: date) { (success, error) in
                        if let error = error {
                            callback(.failure(error))
                        } else {
                            callback(.success(success))
                        }
                    }
                }
            },
            pause: {
                .fireAndForget {
                    session.pause()
                }
            },
            resume: {
                .fireAndForget {
                    session.resume()
                }
            },
            end: {
                .fireAndForget {
                    session.end()
                }
            },
            sessionDelegate:
                Effect
                .run { subscriber in
                    var delegate: Optional = SessionDelegate(subscriber: subscriber)
                    session.delegate = delegate
                    return AnyCancellable {
                        delegate = nil
                    }
                }
                .share()
                .eraseToEffect(),
            builderDelegate:
                Effect
                .run { subscriber in
                    var delegate: Optional = BuilderDelegate(subscriber: subscriber)
                    builder.delegate = delegate
                    return AnyCancellable {
                        delegate = nil
                    }
                }
                .share()
                .eraseToEffect()
        )
    }
    
    fileprivate class SessionDelegate: NSObject, HKWorkoutSessionDelegate {
        let subscriber: Effect<HealthClient.SessionDelegateEvent, Never>.Subscriber

        init(subscriber: Effect<HealthClient.SessionDelegateEvent, Never>.Subscriber) {
          self.subscriber = subscriber
        }
        
        func workoutSession(_ workoutSession: HKWorkoutSession, didFailWithError error: Error) {
            self.subscriber.send(
                .workoutSession(workoutSession: workoutSession, didFailtWithError: error)
            )
        }
        
        func workoutSession(_ workoutSession: HKWorkoutSession, didGenerate event: HKWorkoutEvent) {
            self.subscriber.send(
                .workoutSession(workoutSession: workoutSession, didGenerate: event)
            )
        }
        
        func workoutSession(_ workoutSession: HKWorkoutSession, didChangeTo toState: HKWorkoutSessionState, from fromState: HKWorkoutSessionState, date: Date) {
            self.subscriber.send(
                .workoutSession(workoutSession: workoutSession, toState: toState, fromState: fromState, date: date)
            )
        }
    }
    
    fileprivate class BuilderDelegate: NSObject, HKLiveWorkoutBuilderDelegate {
        let subscriber: Effect<HealthClient.BuilderDelegateEvent, Never>.Subscriber

        init(subscriber: Effect<HealthClient.BuilderDelegateEvent, Never>.Subscriber) {
          self.subscriber = subscriber
        }
        
        func workoutBuilderDidCollectEvent(_ workoutBuilder: HKLiveWorkoutBuilder) {
            self.subscriber.send(
                .workoutBuilderDidCollectEvent(workoutBuilder: workoutBuilder)
            )
        }
        
        func workoutBuilder(_ workoutBuilder: HKLiveWorkoutBuilder, didCollectDataOf collectedTypes: Set<HKSampleType>) {
            self.subscriber.send(
                .workoutBuilder(workoutBuilder: workoutBuilder, didCollectDataOf: collectedTypes)
            )
        }
    }
}

