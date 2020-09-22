//
//  ActiveMatchView.swift
//  TopSpinWatch WatchKit Extension
//
//  Created by Will Brandin on 9/22/20.
//

import SwiftUI

struct ActiveMatchSwipeView: View {
    
    @State var playerOneScore: Int = 0
    @State var playerTwoScore: Int = 0
    @State var label: String = ""
    @State var translation: CGFloat = 0
    @State var playerOneOpacity: Double = 0
    @State var playerTwoOpacity: Double = 0
    @State var centralOpacity: Double = 1
    var body: some View {
        ZStack {
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
                                .foregroundColor(.orange)
                            Text("\(playerOneScore)")
                        }
                        Text("-")
                        HStack {
                            Text("\(playerTwoScore)")
                            Circle()
                                .frame(width: 5, height: 5)
                                .foregroundColor(.clear)
                        }
                    }
                    .font(.title)
                    Spacer()
                }
            }
            .opacity(centralOpacity)
            
            VStack {
                Text("Player One Scored")
                    .opacity(playerOneOpacity)
                    .offset(y: translation)
                
                Spacer()
            }
            
            VStack {
                Spacer()
                Text("Player Two Scored")
                    .offset(y: translation * 0.5)
                    .opacity(playerTwoOpacity)
            }
        }
        .gesture(
            DragGesture(minimumDistance: 3.0, coordinateSpace: .local)
                .onChanged { value in
                    if value.translation.width < 100 && value.translation.width > -100 {
                        if translation < 0 && translation < 100 {
                            translation = value.translation.height
                            playerTwoOpacity = Double(translation) * -1 * 0.01
                            playerOneOpacity = 0
                            centralOpacity = max(1 - playerTwoOpacity, 0.25)
                        } else {
                            translation = value.translation.height  * 0.5
                            playerOneOpacity = Double(translation) * 0.03
                            playerTwoOpacity = 0
                            centralOpacity = max(1 - playerOneOpacity, 0.25)
                        }
                    }
                }
                .onEnded { value in
                    if value.translation.height < -50 && value.translation.width < 100 && value.translation.width > -100 {
                        playerTwoScore += 1
                    } else if value.translation.height > 50 && value.translation.width < 100 && value.translation.width > -100 {
                        playerOneScore += 1
                    }
                    
                    translation = 0
                    playerOneOpacity = 0
                    playerTwoOpacity = 0
                    centralOpacity = 1
                }
        )
        
    }
}

struct ActiveMatchSwipeView_Previews: PreviewProvider {
    static var previews: some View {
        ActiveMatchSwipeView()
    }
}
