//
//  ActiveMatchView.swift
//  TopSpinWatch WatchKit Extension
//
//  Created by Will Brandin on 9/22/20.
//

import SwiftUI

struct ActiveMatchView: View {
    var body: some View {
        ScrollView {
            VStack {
                Text("MATCH POINT")
                    .font(.caption2)
                    .bold()
                    .padding(2)
                    .background(Color.orange)
                    .cornerRadius(2)
                
                HStack {
                    Spacer()
                    HStack {
                        HStack {
                            Circle()
                                .frame(width: 5, height: 5)
                                .foregroundColor(.green)
                            Text("10")
                        }
                        Text("-")
                        HStack {
                            Text("8")
                            Circle()
                                .frame(width: 5, height: 5)
                                .foregroundColor(.clear)
                        }
                    }
                    .font(.title)
                    Spacer()
                }
                
                Spacer()
                
                Button("Player 1") {
                    
                }
                Button("Player 2") {
                    
                }
                
                Button("Cancel") {
                    
                }
                .buttonStyle(BorderedButtonStyle(tint: .red))
                .padding(.top, 24)
            }
        }
    }
}

struct ActiveMatchView_Previews: PreviewProvider {
    static var previews: some View {
        ActiveMatchView()
    }
}
