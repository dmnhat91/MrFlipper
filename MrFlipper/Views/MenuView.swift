//
//  MenuView.swift
//  MrFlipper
//
//  Created by Duong Minh Nhat on 28/08/2022.
//

import SwiftUI

struct MenuView: View {
    let userName: String
    
    var body: some View {
//        NavigationView {
            ZStack{
                ColorConstants.themeColor
                    .opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack {
                        Image("app-logo-transparent")
                                .offset(y: -100)
                                .padding(.bottom, -200)
                                      
                        HStack {
                            Text("Game mode")
                                .bold()
                                .modifier(gameTextStyle())
                            Spacer()
                        }
                        
                        NavigationLink {
                            GameView(userName: userName, totalTime: Constants.totalTimeEasyMode, pointMinus: Constants.pointsEasyModeDeduct, pointAdd: Constants.pointsEasyModeAdd, playConfig: PlayConfig(timeRemaining: Constants.totalTimeEasyMode))
                        } label: {
                            MenuItemView(text: "Easy")
                        }
                        
                        NavigationLink {
                            GameView(userName: userName, totalTime: Constants.totalTimeMediumMode, pointMinus: Constants.pointsMediumModeDeduct, pointAdd: Constants.pointsMediumModeAdd, playConfig: PlayConfig(timeRemaining: Constants.totalTimeMediumMode))
                        } label: {
                            MenuItemView(text: "Medium")
                        }
                        NavigationLink {
                            GameView(userName: userName, totalTime: Constants.totalTimeHardMode, pointMinus: Constants.pointsHardModeDeduct, pointAdd: Constants.pointsHardModeAdd, playConfig: PlayConfig(timeRemaining: Constants.totalTimeHardMode))
                        } label: {
                            MenuItemView(text: "Hard")
                        }
                        
                        HStack {
                            Text("Instructions")
                                .bold()
                                .modifier(gameTextStyle())
                            
                            Spacer()
                        }
                        
                        NavigationLink {
                            // ???: to config game config here
                            // ???: switch to how to play screen
                        } label: {
                            MenuItemView(text: "How to play")
                        }
                        
                        
                        HStack {
                            Text("Leaderboard")
                                .bold()
                                .modifier(gameTextStyle())
                            
                            Spacer()
                        }
                        
                        NavigationLink {
                            LeaderboardView()
                        } label: {
                            MenuItemView(text: "Leaderboard")
                        }
                    } //VStack
                }
            } //ZStack
            .onAppear {
                playSound(sound: "bg-music", type: "mp3")
            }
//        } //NavigationView
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(userName: "minhnhat")
    }
}
    
