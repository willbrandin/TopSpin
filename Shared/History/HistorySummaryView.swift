//
//  HistorySummaryView.swift
//  TopSpin
//
//  Created by Will Brandin on 9/21/20.
//

import SwiftUI

struct HistorySummaryView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Summary")
                    .font(.title3)
                    .bold()
                
                Spacer()
            }
            .padding(.bottom, 8)
                        
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Wins")
                        .font(.caption)
                        .foregroundColor(.green)
                        .bold()
                    
                    Text("32")
                        .font(Font.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                }
                
                Divider()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Loses")
                        .font(.caption)
                        .foregroundColor(.red)
                        .bold()
                    Text("12")
                        .font(Font.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                }
                
                Divider()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Calories")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .bold()
                    HStack(spacing: 0) {
                        Text("5,788")
                            .font(Font.system(.title3, design: .rounded))
                            .fontWeight(.bold)
                            .bold()
                        
                        Text("CAL")
                            .font(Font.system(.title3, design: .rounded).smallCaps())
                            .fontWeight(.bold)
                    }
                }
                
                Divider()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Heart Rate")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .bold()
                    HStack(spacing: 0) {
                        Text("140")
                            .font(Font.system(.title3, design: .rounded))
                            .fontWeight(.bold)
                        Text("BPM")
                            .font(Font.system(.title3, design: .rounded).smallCaps())
                            .fontWeight(.bold)
                    }
                }
            }
            .frame(minHeight: 50)
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(8)
        .padding(.horizontal)
    }
}

struct HistorySummaryView_Previews: PreviewProvider {
    static var previews: some View {
        HistorySummaryView()
            .frame(height: 200)
    }
}
