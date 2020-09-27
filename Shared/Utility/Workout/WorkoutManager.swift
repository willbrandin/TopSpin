//
//  WorkoutManager.swift
//  TopSpinWatch WatchKit Extension
//
//  Created by Will Brandin on 9/22/20.
//

import Foundation
import HealthKit
import Combine

// https://developer.apple.com/documentation/healthkit/workouts_and_activity_rings/speedysloth_creating_a_workout
class WorkoutManager: NSObject, ObservableObject {
        
    static let shared = WorkoutManager()
        
    // MARK: - DeclareSessionBuilder
    
    let healthStore = HKHealthStore()
    var session: HKWorkoutSession!
    var builder: HKLiveWorkoutBuilder!
    
    // MARK: - Publishers
            
    @Published private var heartRate: Int = 0
    @Published private var activeCalories: Int = 0
    @Published private var elapsedSeconds: Int = 0
    @Published private var heartMetrics: WorkoutHeartMetric = WorkoutHeartMetric(averageHeartRate: 0, maxHeartRate: 0, minHeartRate: 0)
    
    var workoutPublisher: AnyPublisher<WorkoutState, Never> {
        Publishers.CombineLatest4($heartRate.eraseToAnyPublisher(), $activeCalories.eraseToAnyPublisher(), $elapsedSeconds.eraseToAnyPublisher(), $heartMetrics.eraseToAnyPublisher())
            .map { (heartRate: Int, calories: Int, time: Int, metrics: WorkoutHeartMetric) in
                return WorkoutState(heartMetrics: metrics, heartRate: heartRate, activeCalories: calories, elapsedSeconds: time, startDate: self.workoutStart, endDate: nil)
            }
            .eraseToAnyPublisher()
    }
    
    
    // MARK: - Properties

    // The app's workout state.
    var isWorkoutActive: Bool = false
    
    // The cancellable holds the timer publisher.
    var start: Date = Date()
    
    var workoutStart: Date? {
        session.startDate
    }
    
    var workoutEndDate: Date? {
        session.endDate
    }
    
    var cancellable: Cancellable?
    var accumulatedTime: Int = 0
    
    // MARK: - Methods
    
    // Set up and start the timer.
    func setUpTimer() {
        start = Date()
        cancellable = Timer.publish(every: 0.1, on: .main, in: .default)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.elapsedSeconds = self.incrementElapsedTime()
            }
    }
    
    // Calculate the elapsed time.
    func incrementElapsedTime() -> Int {
        let runningTime: Int = Int(-1 * (self.start.timeIntervalSinceNow))
        return self.accumulatedTime + runningTime
    }
    
    // Request authorization to access HealthKit.
    func requestAuthorization() {
        // The quantity type to write to the health store.
        let typesToShare: Set = [
            HKQuantityType.workoutType()
        ]
        
        // The quantity types to read from the health store.
        let typesToRead: Set = [
            HKQuantityType.quantityType(forIdentifier: .heartRate)!,
            HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!
        ]
        
        // Request authorization for those quantity types.
        healthStore.requestAuthorization(toShare: typesToShare, read: typesToRead) { (success, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if !success {
                print("Failed to begin builder.")
            }
        }
    }
    
    // Provide the workout configuration.
    func workoutConfiguration() -> HKWorkoutConfiguration {
        let configuration = HKWorkoutConfiguration()
        configuration.activityType = .tableTennis
        configuration.locationType = .indoor
        
        return configuration
    }
    
    // Start the workout.
    func startWorkout() {
        // Start the timer.
        setUpTimer()
        self.isWorkoutActive = true
        
        // Create the session and obtain the workout builder.
        do {
            session = try HKWorkoutSession(healthStore: healthStore, configuration: self.workoutConfiguration())
            builder = session.associatedWorkoutBuilder()
        } catch {
            // Handle any exceptions.
            return
        }
        
        // Setup session and builder.
        session.delegate = self
        builder.delegate = self
        
        // Set the workout builder's data source.
        builder.dataSource = HKLiveWorkoutDataSource(healthStore: healthStore,
                                                     workoutConfiguration: workoutConfiguration())
        
        // Start the workout session and begin data collection.
        print("Workout did Start")
        session.startActivity(with: Date())
        builder.beginCollection(withStart: Date()) { (success, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if !success {
                print("Failed to begin builder.")
            }
        }
    }
    
    // MARK: - State Control
    
    func togglePause() {
        // If you have a timer, then the workout is in progress, so pause it.
        if isWorkoutActive {
            self.pauseWorkout()
        } else {// if session.state == .paused { // Otherwise, resume the workout.
            resumeWorkout()
        }
    }
    
    func pauseWorkout() {
        if session.state == .paused {
            return
        }
        
        print("Workout did Pause")
        // Pause the workout.
        session.pause()
        // Stop the timer.
        cancellable?.cancel()
        // Save the elapsed time.
        accumulatedTime = elapsedSeconds
        isWorkoutActive = false
    }
    
    func resumeWorkout() {
        print("Workout did Resume")
        // Resume the workout.
        session.resume()
        // Start the timer.
        setUpTimer()
        isWorkoutActive = true
    }
    
    func endWorkout() {
        // End the workout session.
        session.end()
        cancellable?.cancel()
    }
    
    func resetWorkout() {
        // Reset the published values.
        DispatchQueue.main.async {
            self.elapsedSeconds = 0
            self.activeCalories = 0
            self.heartRate = 0
        }
    }
    
    // MARK: - Update the UI
    
    // Update the published values.
    func updateForStatistics(_ statistics: HKStatistics?) {
        guard let statistics = statistics, isWorkoutActive else { return }
        
        print("Workout did Receive Stats")
        DispatchQueue.main.async {
            switch statistics.quantityType {
            case HKQuantityType.quantityType(forIdentifier: .heartRate):
                /// - Tag: SetLabel
                let heartRateUnit = HKUnit.count().unitDivided(by: HKUnit.minute())
                
                let mostRctValue = statistics.mostRecentQuantity()?.doubleValue(for: heartRateUnit)
                let avgValue = statistics.averageQuantity()?.doubleValue(for: heartRateUnit)
                
                let maxValue = statistics.maximumQuantity()?.doubleValue(for: heartRateUnit)
                let minValue = statistics.minimumQuantity()?.doubleValue(for: heartRateUnit)
                
                let roundedValue = Double( round( 1 * mostRctValue! ) / 1 )
                let roundedAvg = Int(Double( round( 1 * avgValue! ) / 1 ))
                let roundedMin = Int(Double( round( 1 * minValue! ) / 1 ))
                let roundedMax = Int(Double( round( 1 * maxValue! ) / 1 ))
                
                self.heartRate = Int(roundedValue)
                self.heartMetrics = WorkoutHeartMetric(averageHeartRate: roundedAvg, maxHeartRate: roundedMax, minHeartRate: roundedMin)
                
            case HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned):
                let energyUnit = HKUnit.kilocalorie()
                let value = statistics.sumQuantity()?.doubleValue(for: energyUnit)
                self.activeCalories = Int(Double( round( 1 * value! ) / 1 ))
                return
             
            default:
                return
            }
        }
    }
}

// MARK: - HKWorkoutSessionDelegate

extension WorkoutManager: HKWorkoutSessionDelegate {
    func workoutSession(_ workoutSession: HKWorkoutSession, didChangeTo toState: HKWorkoutSessionState,
                        from fromState: HKWorkoutSessionState, date: Date) {
        // Wait for the session to transition states before ending the builder.
        if toState == .ended {
            
            // TODO: - Create Model and Pass to delegate.
            
            print("The workout has now ended.")
            builder.endCollection(withEnd: Date()) { (success, error) in
                self.builder.finishWorkout { (workout, error) in
                    // Optionally display a workout summary to the user.
                    self.resetWorkout()
                }
            }
        }
    }
    
    func workoutSession(_ workoutSession: HKWorkoutSession, didFailWithError error: Error) {
        
    }
}

// MARK: - HKLiveWorkoutBuilderDelegate

extension WorkoutManager: HKLiveWorkoutBuilderDelegate {
    func workoutBuilderDidCollectEvent(_ workoutBuilder: HKLiveWorkoutBuilder) {
    }
    
    func workoutBuilder(_ workoutBuilder: HKLiveWorkoutBuilder, didCollectDataOf collectedTypes: Set<HKSampleType>) {
        for type in collectedTypes {
            guard let quantityType = type as? HKQuantityType else {
                return // Nothing to do.
            }
            
            /// - Tag: GetStatistics
            let statistics = workoutBuilder.statistics(for: quantityType)
            
            // Update the published values.
            updateForStatistics(statistics)
        }
    }
}
