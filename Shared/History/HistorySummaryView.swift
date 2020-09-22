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
                        .font(Font.system(size: 18, weight: .bold, design: .rounded))
                }
                
                Divider()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Loses")
                        .font(.caption)
                        .foregroundColor(.red)
                        .bold()
                    Text("12")
                        .font(Font.system(size: 18, weight: .bold, design: .rounded))
                        .bold()
                }
                
                Divider()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Calories")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .bold()
                    Text("5,788 cal")
                        .font(Font.system(size: 18, weight: .bold, design: .rounded))
                        .bold()
                }
                
                Divider()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Heart Rate")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .bold()
                    Text("143 bpm")
                        .font(Font.system(size: 18, weight: .bold, design: .rounded))
                        .bold()
                }
            }
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
