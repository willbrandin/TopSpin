//
//  HeartRateValueView.swift
//  TopSpin
//
//  Created by Will Brandin on 9/25/20.
//

import SwiftUI

struct HeartRateValueView: View {
    var title: String
    var subtitle: String
    
    var body: some View {
        VStack {
            Text(title.uppercased())
                .font(.caption)
                .foregroundColor(.secondary)
            
            Text(subtitle)
                .font(.title2)
        }
    }
}

struct HeartRateValueView_Previews: PreviewProvider {
    static var previews: some View {
        HeartRateValueView(title: "AVG", subtitle: "160")
            .previewLayout(.sizeThatFits)
    }
}
