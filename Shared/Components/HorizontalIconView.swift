//
//  HorizontalIconView.swift
//  TopSpin
//
//  Created by Will Brandin on 9/25/20.
//

import SwiftUI

struct HorizontalIconView: View {
    var image: Image
    var tint: Color
    var title: String
    var value: String
    var unit: String
    
    var body: some View {
        HStack {
            image
                .foregroundColor(tint)
                .font(.headline)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.caption)
                    .bold()
                    .foregroundColor(.secondary)
                
                HStack(spacing: 0) {
                    Text(value)
                        .font(.callout)
                        .bold()
                    Text(unit.uppercased())
                        .font(Font.callout.smallCaps())
                        .bold()
                }
            }
        }
    }
}

struct HorizontalIconView_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalIconView(image: Image(systemName:"clock"), tint: .yellow, title: "Duration", value: "12", unit: "MIN")
    }
}
