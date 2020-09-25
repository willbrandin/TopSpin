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
                
                Text("Sep 1 - Sep 14")
                    .font(.caption2)
                    .foregroundColor(.secondary)
                    .bold()
            }
            .padding(.bottom, 8)
                        
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Wins")
                        .font(.caption2)
                        .foregroundColor(.green)
                        .bold()
                    
                    Text("32")
                        .font(Font.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                }
                
                Divider()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Loses")
                        .font(.caption2)
                        .foregroundColor(.red)
                        .bold()
                    Text("12")
                        .font(Font.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                }
                
                Divider()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Calories")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                        .bold()
                    Text("5,788")
                        .font(Font.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                        .bold()
                }
                
                Divider()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Avg. Heart Rate")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                        .bold()
                    Text("140")
                        .font(Font.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                }
            }
            .frame(minHeight: 50)
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(8)
    }
}

struct HistorySummaryView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            HistorySummaryView()
                .padding()
            Spacer()
        }
            
    }
}