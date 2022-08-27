//
//  WinModalView.swift
//  MrFlipper
//
//  Created by Duong Minh Nhat on 27/08/2022.
//

import SwiftUI

struct WinModalView: View {
    let score = 100
    
    var body: some View {
        ZStack{
            Color("LightTheme")
                .edgesIgnoringSafeArea(.all)
            VStack{
                Text("YOU WON")
                    .font(.system(.title, design: .rounded))
                    .fontWeight(.heavy)
                    .foregroundColor(Color.white)
                    .padding()
                    .frame(minWidth: 280, idealWidth: 280, maxWidth: 320)
                    .background(Color("RedDark"))
                
                Spacer()
                
                VStack {
                    Image("app-logo")
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 150)
                    Text("YOUR SCORE: \(score)")
                        .font(.system(.body, design: .rounded))
                        .foregroundColor(Color("RedDark"))
                        .bold()
                        .multilineTextAlignment(.center)
                    Button {
//                        self.showGameOverModal = false
//                        self.coins = 100
                    } label: {
                        Text("Play again".uppercased())
                            .foregroundColor(Color("RedDark"))
                    }
                    .padding(.vertical,10)
                    .padding(.horizontal, 20)
                    .background(
                        Capsule()
                            .strokeBorder(lineWidth: 2)
                            .foregroundColor(Color("RedDark"))
                    )

                }
                
                Spacer()
            }
            .frame(minWidth: 280, idealWidth: 280, maxWidth: 320, minHeight: 280, idealHeight: 300, maxHeight: 350, alignment: .center)
            .background(Color("LightTheme"))
            .border(Color("RedDark"), width: 5)
            .cornerRadius(10)
        }
    }
}

struct WinModalView_Previews: PreviewProvider {
    static var previews: some View {
        WinModalView()
    }
}
