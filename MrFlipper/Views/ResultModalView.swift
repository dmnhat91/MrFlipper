//
//  WinModalView.swift
//  MrFlipper
//
//  Created by Duong Minh Nhat on 27/08/2022.
//

import SwiftUI

struct ResultModalView: View {
    let displayText: String
    let isWin: Bool
    
    @Binding var playConfig : PlayConfig
    @Binding var gameConfig : GameConfig
    
    var body: some View {
        ZStack{
            ColorConstants.themeColor
                .opacity(0.5)
                .edgesIgnoringSafeArea(.all)
            VStack{
                Text("\(displayText)")
                    .font(.system(.title, design: .rounded))
                    .fontWeight(.heavy)
                    .foregroundColor(Color.white)
                    .padding()
                    .frame(minWidth: 280, idealWidth: 280, maxWidth: 320)
                    .background(ColorConstants.darkTextColorTheme)
                
                Spacer()
                
                VStack {
                    Image("app-logo")
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 150)
                    Text("YOUR SCORE: \(playConfig.score)")
                        .font(.system(.body, design: .rounded))
                        .foregroundColor(ColorConstants.darkTextColorTheme)
                        .bold()
                        .multilineTextAlignment(.center)
                    Button {
                        if isWin {
                            playConfig.showWinModal = false
                        } else {
                            playConfig.showLoseModal = false
                        }
                        playConfig.reset()
                        gameConfig.resetCards()
                    } label: {
                        Text("Play again".uppercased())
                            .foregroundColor(ColorConstants.darkTextColorTheme)
                    }
                    .padding(.vertical,10)
                    .padding(.horizontal, 20)
                    .background(
                        Capsule()
                            .strokeBorder(lineWidth: 2)
                            .foregroundColor(ColorConstants.darkTextColorTheme)
                    )

                }
                
                Spacer()
            }
            .frame(minWidth: 280, idealWidth: 280, maxWidth: 320, minHeight: 280, idealHeight: 300, maxHeight: 350, alignment: .center)
            .background(ColorConstants.themeColor)
            .border(ColorConstants.darkTextColorTheme, width: 5)
            .cornerRadius(10)
        }
    }
}

struct WinModalView_Previews: PreviewProvider {
    @State static var playConfig = PlayConfig()
    @State static var gameConfig = GameConfig(cards: gameCards)
    
    static var previews: some View {
        ResultModalView(displayText: "YOU WON", isWin: true, playConfig: $playConfig, gameConfig: $gameConfig)
    }
}
