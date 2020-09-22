//
//  MatchSummaryView.swift
//  TopSpin
//
//  Created by Will Brandin on 9/22/20.
//

import SwiftUI

struct MatchSummaryView: View {
    
    var workoutMetrics: some View {
        VStack {
            Divider()
            
            HStack {
                VStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Total Time")
                        Text("0:28:32")
                            .font(Font.system(.title, design: .rounded))
                            .foregroundColor(.yellow)
                    }
                }
                
                Spacer()
                
                VStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Avg. Heart Rate")
                        HStack(spacing: 0) {
                            Text("160")
                                .font(Font.system(.title, design: .rounded))
                                .foregroundColor(.red)
                            Text("BPM")
                                .font(Font.system(.title, design: .rounded).smallCaps())
                                .foregroundColor(.red)
                        }
                    }
                }
                Spacer()
                Spacer()
            }
            .padding()
            
            Divider()

            HStack {
                VStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Active Calories")
                        HStack(spacing: 0) {
                            Text("509")
                                .font(Font.system(.title, design: .rounded))
                                .foregroundColor(.green)
                            Text("CAL")
                                .font(Font.system(.title, design: .rounded).smallCaps())
                                .foregroundColor(.green)
                        }
                    }
                }
                
                Spacer()
                
                VStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Total Calories")
                        HStack(spacing: 0) {
                            Text("690")
                                .font(Font.system(.title, design: .rounded))
                                .foregroundColor(.green)
                            Text("CAL")
                                .font(Font.system(.title, design: .rounded).smallCaps())
                                .foregroundColor(.green)
                        }
                    }
                }
                Spacer()
                Spacer()
            }
            .padding()
            
            Divider()
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("WIN")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.green)
                        
                        HStack {
                            Text("11")
                                .bold()
                            Text("-")
                                .bold()
                            Text("8")
                                .bold()
                                                
                        }
                        .font(.largeTitle)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("11:12 AM - 11:41 AM")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            
                            HStack {
                                Image(systemName: "location.fill")
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                                Text("Dallas")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    
                    Spacer()
                }
                .padding()
                
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
}

struct MatchSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MatchSummaryView()
        }
        .preferredColorScheme(.dark)
    }
}
