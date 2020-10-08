//
//  MetricGraphView.swift
//  TopSpin
//
//  Created by Will Brandin on 10/8/20.
//

import SwiftUI

struct VerticalBarChart: View {
    
    var data: [Double]
    var foregroundColor: ColorGradient
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            BarChart()
                .environmentObject(ChartData(data))
                .environmentObject(ChartStyle(backgroundColor: .clear, foregroundColor: foregroundColor))
                .padding(.trailing, 8)
            
            HStack {
                ChartGrid()
                    .stroke(
                        Color.secondary,
                        style: StrokeStyle(
                            lineWidth: 1,
                            lineCap: .round,
                            lineJoin: .round,
                            miterLimit: 0,
                            dash: [1, 8],
                            dashPhase: 0
                        )
                    )
                
                VStack(spacing: 0) {
                    data.max().map {
                        Text(String(Int($0)))
                            .foregroundColor(.secondary)
                            .font(.caption)
                    }
                    Spacer()
                    data.max().map {
                        Text(String(Int($0 / 2)))
                            .foregroundColor(.secondary)
                            .font(.caption)
                    }
                    Spacer()
                }
            }
        }
    }
}

struct MetricGraphView: View {
    
    var title: String
    var labels: [String]
    var data: [Double]
    var foregroundColor: ColorGradient

    private let labelCount = 4

    private var threshold: Int {
        let threshold = Double(data.count) / Double(labelCount)
        return Int(threshold.rounded(.awayFromZero))
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .foregroundColor(.secondary)
                    .font(.subheadline)
                Spacer()
            }
            .padding(.top)
            .padding(.horizontal)
            
            VerticalBarChart(data: data, foregroundColor: foregroundColor)
                .frame(height: 100)
                .padding(.horizontal)
            
            
            HStack(spacing: 0) {
                ForEach(labels.indexed(), id: \.0.self) { index, item in
                    if index % self.threshold == 0 {
                        Text(item)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondary)
                            .font(.caption)
                        
                        Spacer()
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

struct MetricGraphView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MetricGraphView(title: "My Graph", labels: ["Hello", "Labels"], data: [4, 1], foregroundColor: ColorGradient(.red, .pink))
                .previewLayout(.sizeThatFits)
            
            MetricGraphView(title: "My Graph", labels: ["Hello", "Labels"], data: [4,5,6,1,4], foregroundColor: ColorGradient(.red, .pink))
                .previewLayout(.sizeThatFits)
            MetricGraphView(title: "My Graph", labels: ["Hello", "Labels"], data: [4,5,6,1,4, 4,5,6,1,4, 4,5,6,1,4, 4,5,6,1,4], foregroundColor: ColorGradient(.red, .pink))
                .previewLayout(.sizeThatFits)
        }
    }
}
