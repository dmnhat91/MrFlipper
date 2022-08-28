//
//  MenuView.swift
//  MrFlipper
//
//  Created by Duong Minh Nhat on 28/08/2022.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        ZStack{
            ColorConstants.themeColor
                .opacity(0.5)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Image("app-logo-transparent")
                        .offset(y: -100)
                        .padding(.bottom, -200)
                
                HStack {
                    Text("Game mode")
                        .bold()
                        .modifier(gameTextStyle())
                    
                    Spacer()
                    
                    Image(systemName: "person.fill.badge.plus")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(ColorConstants.darkTextColorTheme)
                        .padding(.trailing)
                }
                
                MenuItemView(text: "Easy")
                MenuItemView(text: "Medium")
                MenuItemView(text: "Hard")
                
                HStack {
                    Text("Instructions")
                        .bold()
                        .modifier(gameTextStyle())
                    
                    Spacer()
                }
                
                MenuItemView(text: "How to play")
                
                HStack {
                    Text("Leaderboard")
                        .bold()
                        .modifier(gameTextStyle())
                    
                    Spacer()
                }
                
                MenuItemView(text: "Leaderboard")
                
            }
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
