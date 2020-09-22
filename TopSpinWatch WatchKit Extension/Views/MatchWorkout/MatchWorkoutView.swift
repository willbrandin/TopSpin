//
//  MatchWorkoutView.swift
//  TopSpinWatch WatchKit Extension
//
//  Created by Will Brandin on 9/22/20.
//

import SwiftUI

struct MatchWorkoutView: View {
    var body: some View {
        ScrollView {
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text("12:34.64")
                        .font(.title2)
                        .foregroundColor(.yellow)
                                    
                    HStack {
                        Text("132")
                            .font(.title2)
                        VStack(alignment: .leading, spacing: 0) {
                            Text("ACTIVE")
                            Text("CAL")
                        }
                        .font(Font.system(size: 11))
                        .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Text("98")
                            .font(.title2)
                        VStack(alignment: .leading, spacing: 0) {
                            Text("TOTAL")
                            Text("CAL")
                        }
                        .font(Font.system(size: 11))
                        .foregroundColor(.secondary)
                    }
                    
                    HStack(alignment: .firstTextBaseline) {
                        Text("98")
                            .font(.title2)
                        Text("BPM")
                            .font(Font.system(.title2).smallCaps())
                        Image(systemName: "heart.fill")
                            .foregroundColor(.red)
                            .font(.title3)
                            .padding(.leading)
                    }
                    
                    Button("Cancel") {
                        
                    }
                    .padding(.top, 24)
                }
                
                Spacer()
            }
        }
        .navigationTitle("Workout")
    }
}

struct MatchWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MatchWorkoutView()
        }
    }
}
