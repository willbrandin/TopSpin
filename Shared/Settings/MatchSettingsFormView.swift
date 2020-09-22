//
//  MatchSettingsFormView.swift
//  TopSpin
//
//  Created by Will Brandin on 9/22/20.
//

import SwiftUI

struct MatchSettingsFormView: View {
    
    @State private var settingsName: String = ""
    @State private var scoreLimit: Int = 11
    @State private var winByTwo: Bool = true
    @State private var trackWorkoutData: Bool = true
    
    private var scores = [11, 21]
    
    var body: some View {
        Form {
            Section {
                TextField("My Settings", text: $settingsName)
                Text("Give your settings a custom name.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Section {
                VStack {
                    #if os(watchOS)
                    Picker("Score Limit", selection: $scoreLimit) {
                        Text("11").tag(11)
                        Text("21").tag(21)
                    }
                    #else
                    Text("What are you playing up to?")
                    Picker("Score Limit", selection: $scoreLimit) {
                        Text("11").tag(11)
                        Text("21").tag(21)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    #endif
                }
                .padding(.vertical)
                                
                Toggle("Win by Two", isOn: $winByTwo)
                Toggle("Track Workout", isOn: $trackWorkoutData)
            }
            
            Section {
                Button("Save Match Settings", action: {})
            }
        }
        .navigationTitle("Match Settings")
    }
}

struct MatchSettingsFormView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MatchSettingsFormView()
        }
//        .preferredColorScheme(.dark)
    }
}

#if os(macOS)
extension View {
    func navigationBarTitle(_ title: String) -> some View {
        self
    }
    
    func navigationTitle(_ title: String) -> some View {
        self
    }
}
#endif
