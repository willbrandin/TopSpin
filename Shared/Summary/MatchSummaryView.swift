//
//  MatchSummaryView.swift
//  TopSpin
//
//  Created by Will Brandin on 9/22/20.
//

import SwiftUI

struct MatchSummaryView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var yellowColor: Color {
        return colorScheme == .dark ? .yellow : Color(UIColor.label)
    }
    
    var largeMetricSection: some View {
        HStack {
            LargeMetricView(title: "Duration") {
                Text("0:28:32")
                    .font(Font.system(.title, design: .rounded))
                    .foregroundColor(yellowColor)
            }
            .previewLayout(.sizeThatFits)
            
            Spacer()
            
            LargeMetricView(title: "Active Calories") {
                HStack(spacing: 0) {
                    Text("509")
                        .font(Font.system(.title, design: .rounded))
                        .foregroundColor(.green)
                    Text("CAL")
                        .font(Font.system(.title, design: .rounded).smallCaps())
                        .foregroundColor(.green)
                }
            }
            
            Spacer()
            Spacer()
        }
        .padding()
    }
    
    var workoutMetrics: some View {
        VStack {
            Divider()
            
            largeMetricSection
            
            Divider()

            VStack(alignment: .leading) {
                Text("Heart Rate")
                    .font(.headline)
                
                HeartRatesView()
            }
            .padding()

            Divider()
        }
    }
    
    var body: some View {
        ScrollView {
            MatchSummaryScoreView()
            
            workoutMetrics
            
            Spacer()
        }
        .toolbar {
            Button(action: {}) {
                Image(systemName: "square.and.arrow.up")
            }
        }
        .navigationTitle("Sat, Sep 9")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MatchSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                MatchSummaryView()
            }
            
            NavigationView {
                MatchSummaryView()
            }
            .preferredColorScheme(.dark)
        }
    }
}
