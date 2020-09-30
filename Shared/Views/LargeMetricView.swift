//
//  LargeMetricView.swift
//  TopSpin
//
//  Created by Will Brandin on 9/25/20.
//

import SwiftUI

struct LargeMetricView<Content>: View where Content: View {
    var title: String
    var content: () -> Content

    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                content()
                    .font(Font.system(.title, design: .rounded))
            }
        }
    }
}

struct LargeMetricView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LargeMetricView(title: "Duration") {
                Text("0:28:32")
                    .foregroundColor(.yellow)
            }
            .previewLayout(.sizeThatFits)
            
            LargeMetricView(title: "Avg. Heart Rate") {
                HStack(spacing: 0) {
                    Text("160")
                        .foregroundColor(.red)
                    Text("BPM")
                        .foregroundColor(.red)
                }
            }
            .previewLayout(.sizeThatFits)
        }
    }
}
