//
//  LeaderboardView.swift
//  MrFlipper
//
//  Created by Duong Minh Nhat on 28/08/2022.
//

import SwiftUI

struct LeaderboardView: View {
//    @Environment(\.dismiss) var dismiss
    
    @State var usersList: [User] = []
    
//    init() {
//        let usersData = getUserDict()
//        for (_, value) in usersData {
//            usersList.append(value)
//        }
//
//        usersList = usersList.sorted(by: {
//            $0.highScore > $1.highScore
//        })
//    }
    
    var body: some View {
        ZStack{
            ColorConstants.themeColor
                .opacity(0.5)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Image("app-logo-transparent")
                        .offset(y: -100)
                        .padding(.bottom, -200)
                
                VStack {
                    Text("Leaderboard")
                        .bold()
                        .foregroundColor(ColorConstants.darkTextColorTheme)
                        .font(.system(size: 36))
                    
                    List(usersList) {
                        LeaderboardItemView(username: $0.username, score: $0.highScore, imageName: $0.badge)
                    }
                    .onAppear(perform: {
                        usersList = loadUsersList()
                    })
                }
                    
            } //end VStack
            
        } //end ZStack
//        .overlay(
//            Button(action: {
//            audioPlayer?.stop()
//            dismiss()
//          }) {
//            Image(systemName: "xmark.circle")
//              .font(.title)
//          }
//            .foregroundColor(ColorConstants.darkTextColorTheme)
//            .padding(.top, 30)
//            .padding(.trailing, 20),
//            alignment: .topTrailing
//        )
    }
    
    func loadUsersList() -> [User] {
        let usersData = getUserDict()
        var users = [User]()
        for (_, value) in usersData {
            users.append(value)
        }
        
        users = users.sorted(by: {
            $0.highScore > $1.highScore
        })
        
        return users
    }
}

struct LeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardView()
    }
}
