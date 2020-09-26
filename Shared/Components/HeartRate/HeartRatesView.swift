//
//  HeartRatesView.swift
//  TopSpin
//
//  Created by Will Brandin on 9/25/20.
//

import SwiftUI

struct HeartRatesView: View {
    var body: some View {
        HStack {
            HeartRateValueView(title: "AVG", subtitle: "160")
                .padding(.trailing)

            Divider()

            HeartRateValueView(title: "MIN", subtitle: "145")
                .padding(.horizontal)

            Divider()

            HeartRateValueView(title: "MAX", subtitle: "178")
                .padding(.horizontal)

            Spacer()
        }
    }
}

struct HeartRatesView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HeartRatesView()
                .previewLayout(.fixed(width: 300.0, height: 60))
            HeartRatesView()
                .colorScheme(.dark)
                .previewLayout(.fixed(width: 300.0, height: 60))
        }
    }
}
