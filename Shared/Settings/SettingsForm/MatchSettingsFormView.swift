//
//  MatchSettingsFormView.swift
//  TopSpin
//
//  Created by Will Brandin on 9/22/20.
//

import SwiftUI

struct MatchSettingsFormView: View {
    
    @State private var isEmptyNameError: Bool = false

    @State private var settingsName: String = ""
    @State private var scoreLimit: Int = 11
    @State private var serveInterval: Int = 2
    @State private var winByTwo: Bool = true
    @State private var trackWorkoutData: Bool = true
    @State private var setAsDefault: Bool = true
    
    @EnvironmentObject var store: AppStore
    @Environment(\.presentationMode) var presentationMode
    
    private var setting: MatchSetting?
    
    init(setting: MatchSetting? = nil) {
        self.setting = setting

        self._settingsName = State(wrappedValue: setting?.name ?? "")
        self._scoreLimit = State(wrappedValue: setting?.scoreLimit.rawValue ?? 11)
        self._serveInterval = State(wrappedValue: setting?.serveInterval.rawValue ?? 2)
        self._winByTwo = State(wrappedValue: setting?.isWinByTwo ?? true)
        self._trackWorkoutData = State(wrappedValue: setting?.isTrackingWorkout ?? true)
        self._setAsDefault = State(wrappedValue: setting?.isDefault ?? true)
    }
    
    var formView: some View {
        Form {
            Section {
                TextField("My Settings", text: $settingsName)
                Text("Give your settings a custom name.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Section {
                #if os(watchOS)
                Picker("Score Limit", selection: $scoreLimit) {
                    ForEach(MatchScoreLimit.allCases, id: \.self.rawValue) { limit in
                        Text("\(limit.rawValue)")
                            .tag(limit.rawValue)
                    }
                }
                                
                Picker("Serve Interval", selection: $serveInterval) {
                    ForEach(MatchServeInterval.allCases, id: \.self.rawValue) { interval in
                        Text("\(interval.rawValue)").tag(interval.rawValue)
                    }
                }
                #else
                VStack {
                    Text("What are you playing up to?")
                    Picker("Score Limit", selection: $scoreLimit) {
                        ForEach(MatchScoreLimit.allCases, id: \.self.rawValue) { limit in
                            Text("\(limit.rawValue)")
                                .tag(limit.rawValue)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                
                    Text("How often will you switch servers?")
                    Picker("Serve Interval", selection: $serveInterval) {
                        ForEach(MatchServeInterval.allCases, id: \.self.rawValue) { interval in
                            Text("\(interval.rawValue)")
                                .tag(interval.rawValue)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                .padding(.vertical)
                #endif
            }
            
            Section {
                Toggle("Win by Two", isOn: $winByTwo)
                Toggle("Track Workout", isOn: $trackWorkoutData)
                Toggle("Set as Default", isOn: $setAsDefault)
            }
            
            Section {
                Button("Save Settings", action: onSave)
            }
            .alert(isPresented: $isEmptyNameError) {
                Alert(title: Text("Name for Match Settings cannot be empty"))
            }
        }
        .navigationTitle("Match Settings")
    }
    
    var body: some View {
        #if os(watchOS)
        formView
            .navigationTitle("New Settings")
        #else
        formView
            .navigationTitle("New Settings")

        #endif
    }
    
    private func onSave() {
        guard !settingsName.isEmpty else {
            isEmptyNameError = true
            return
        }
        
        if let setting = self.setting {
            guard let limit = MatchScoreLimit(rawValue: scoreLimit),
                  let interval = MatchServeInterval(rawValue: serveInterval) else {
                return
            }
            
            let setting = MatchSetting(id: setting.id,
                                       createdDate: setting.createdDate,
                                       isDefault: setAsDefault,
                                       isTrackingWorkout: trackWorkoutData,
                                       isWinByTwo: winByTwo,
                                       name: settingsName,
                                       scoreLimit: limit,
                                       serveInterval: interval)
            
            store.send(.settings(action: .update(setting: setting)))
            
        } else {
            guard let limit = MatchScoreLimit(rawValue: scoreLimit),
                  let interval = MatchServeInterval(rawValue: serveInterval) else {
                return
            }
            
            let setting = MatchSetting(id: UUID(),
                                       createdDate: Date(),
                                       isDefault: setAsDefault,
                                       isTrackingWorkout: trackWorkoutData,
                                       isWinByTwo: winByTwo,
                                       name: settingsName,
                                       scoreLimit: limit,
                                       serveInterval: interval)
            
            store.send(.settings(action:.add(setting: setting)))
            
        }
        
        presentationMode.wrappedValue.dismiss()
    }
}

struct MatchSettingsFormView_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationView {
            MatchSettingsFormView()
        }
        .environmentObject(AppEnvironment.mockStore)
    }
}
