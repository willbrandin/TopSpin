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
            }
        }
    }
}

struct LargeMetricView_Previews: PreviewProvider {
    static var previews: some View {
        
        LargeMetricView(title: "Duration") {
            Text("0:28:32")
                .font(Font.system(.title, design: .rounded))
                .foregroundColor(.yellow)
        }
        .previewLayout(.sizeThatFits)
        
        LargeMetricView(title: "Avg. Heart Rate") {
            HStack(spacing: 0) {
                Text("160")
                    .font(Font.system(.title, design: .rounded))
                    .foregroundColor(.red)
                Text("BPM")
                    .font(Font.system(.title, design: .rounded).smallCaps())
                    .foregroundColor(.red)
            }
        }
        .previewLayout(.sizeThatFits)

    }
}
