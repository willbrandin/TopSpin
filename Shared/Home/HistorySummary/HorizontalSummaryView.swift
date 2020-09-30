//
//  HorizontalSummaryView.swift
//  TopSpin
//
//  Created by Will Brandin on 9/22/20.
//

import SwiftUI

struct HorizontalSummaryView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 8) {
                ForEach(0..<6) { _ in
                    HistorySummaryView()
                        .contextMenu {
                            Button(action: {}) {
                                Label("Share", systemImage: "square.and.arrow.up")
                            }
                        }
                }
            }
            .padding(.horizontal)
        }
    }
}

struct HorizontalSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HorizontalSummaryView()
                .preferredColorScheme(.dark)
            HorizontalSummaryView()
                .background(Color(.secondarySystemBackground))
        }
    }
}
