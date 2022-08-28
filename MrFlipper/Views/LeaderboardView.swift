//
//  LeaderboardView.swift
//  MrFlipper
//
//  Created by Duong Minh Nhat on 28/08/2022.
//

import SwiftUI

struct LeaderboardView: View {
    
    var usersList: [User] = []
    
    init() {
        let usersData = getUserDict()
        for (_, value) in usersData {
            usersList.append(value)
        }
        
        usersList = usersList.sorted(by: {
            $0.highScore > $1.highScore
        })
    }
    
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
                }
                    
            } //end VStack
            
        } //end ZStack
    }
    
    func loadUsersList() -> [User] {
        let usersData = getUserDict()
        var users = [User]()
        for (_, value) in usersData {
            users.append(value)
        }
        return users
    }
}

struct LeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardView()
    }
}
