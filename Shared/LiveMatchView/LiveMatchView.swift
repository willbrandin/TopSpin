//
//  LiveMatchView.swift
//  TopSpin
//
//  Created by Will Brandin on 9/25/20.
//

import SwiftUI

struct LiveMatchView: View {
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var regularWidthButtonView: some View {
        HStack {
            Spacer()
            Button(action: {}) {
                Text("Player One")
                    .bold()
                    .foregroundColor(.white)
                    .frame(height: 48)
                    .frame(maxWidth: 300)
                    .background(Color.blue)
                    .cornerRadius(16)
            }
            
            Spacer()
            
            Button(action: {}) {
                Text("Player Two")
                    .bold()
                    .foregroundColor(.white)
                    .frame(height: 48)
                    .frame(maxWidth: 300)
                    .background(Color.blue)
                    .cornerRadius(16)
            }
            Spacer()
        }
        .padding()
        .padding(.bottom)
    }
    
    var compactButtonView: some View {
        VStack(spacing: 16) {
            Button(action: {}) {
                Text("Player One")
                    .bold()
                    .foregroundColor(.white)
                    .frame(height: 48)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
                                    
            Button(action: {}) {
                Text("Player Two")
                    .bold()
                    .foregroundColor(.white)
                    .frame(height: 48)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
        }
        .padding(.horizontal)
        .padding(.bottom)
    }
    
    var buttonView: some View {
        if horizontalSizeClass == .regular {
            return AnyView(regularWidthButtonView)
        } else {
            return AnyView(compactButtonView)
        }
    }
    
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .edgesIgnoringSafeArea(.all)
            
            FloatingLiveWorkoutView()
            
            VStack {
                Spacer()
                
                VStack(spacing: 8) {
                    Text("Match Point".uppercased())
                        .font(.subheadline)
                        .fontWeight(.black)
                        .foregroundColor(.white)
                        .padding(2)
                        .padding(.horizontal, 2)
                        .background(Color.orange)
                        .cornerRadius(6)
                    
                    HStack {
                        Spacer()
                        Circle()
                            .frame(width: 10, height: 10)
                            .foregroundColor(.green)
                        
                        Text("10-8")
                        
                        Circle()
                            .frame(width: 10, height: 10)
                            .foregroundColor(.clear)
                        Spacer()
                    }
                    .padding(.horizontal)
                    .font(Font.system(size: 140, weight: .regular, design: .rounded))
                    .lineLimit(1)
                    .layoutPriority(1)
                    .minimumScaleFactor(0.5)

                    HStack {
                        ForEach(0..<5) { i in
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundColor(i < 2 ? .green : i < 3 ? .red : .gray)
                        }
                    }
                }
                
                Spacer()
                buttonView
            }
        }
    }
}

struct LiveMatchView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LiveMatchView()
                .previewLayout(.fixed(width: 800, height: 370))
                .environment(\.horizontalSizeClass, .regular)
            
            LiveMatchView()
                .preferredColorScheme(.dark)
        }
    }
}
