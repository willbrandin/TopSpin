//
//  FloatingLiveWorkoutView.swift
//  TopSpin
//
//  Created by Will Brandin on 9/25/20.
//

import SwiftUI

struct FloatingLiveWorkoutView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var backgroundColor: Color {
        return colorScheme == .dark ? Color(.tertiarySystemBackground) : Color.black.opacity(0.8)
    }
    
    var body: some View {
        HStack {
            VStack {
                VStack(alignment: .leading) {
                    Text("06:30")
                        .font(Font.system(.largeTitle, design: .rounded))
                        .foregroundColor(.white)
                    
                    HStack(spacing: 2) {
                        Text("150")
                            .font(Font.system(.largeTitle, design: .rounded))
                            .foregroundColor(.white)
                        
                        Image(systemName: "heart.fill")
                            .foregroundColor(.red)
                            .font(.title3)
                            .offset(y: -4)
                    }
                    
                    HStack(alignment: .top, spacing: 2) {
                        Text("100")
                            .font(Font.system(.largeTitle, design: .rounded))
                            .foregroundColor(.white)
                        
                        Text("CAL")
                            .foregroundColor(.red)
                            .font(Font.system(.title3, design: .rounded).bold())
                            .padding(.top, 4)
                    }
                }
                .padding(8)
                .background(backgroundColor)
                .cornerRadius(16)
                .shadow(radius: 4)
                .padding()
                
                Spacer()
            }
            
            Spacer()
        }
    }
}

struct FloatingLiveWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FloatingLiveWorkoutView()
                .previewLayout(.fixed(width: 800, height: 370))
            
            ZStack {
                Color.gray
                
                FloatingLiveWorkoutView()
                    .preferredColorScheme(.dark)
            }
        }
    }
}
