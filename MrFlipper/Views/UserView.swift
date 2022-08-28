//
//  UserView.swift
//  MrFlipper
//
//  Created by Duong Minh Nhat on 28/08/2022.
//

import SwiftUI

struct UserView: View {
    @State var userName = ""
    @State var isLoginSuccess = false
    
    var body: some View {
        NavigationView {
            ZStack{
                ColorConstants.themeColor
                    .opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Image("app-logo-transparent")
                            .offset(y: -100)
                            .padding(.bottom, -200)
                    
                    HStack {
                        NavigationLink {
                            UserLoginView(usernameInput: $userName, isLoginSuccess: $isLoginSuccess)
                            
                        } label: {
                            VStack {
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(ColorConstants.darkTextColorTheme)
                                    .padding(.trailing)
                                Text("User Login")
                                    .bold()
                                    .modifier(gameTextStyle())
                            }
                        }
                        
                        Spacer()
                        
                        NavigationLink {
                            UserRegisterView()
                        } label: {
                            VStack {
                                Image(systemName: "person.fill.badge.plus")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(ColorConstants.darkTextColorTheme)
                                    .padding(.trailing)
                                Text("Add User")
                                    .bold()
                                    .modifier(gameTextStyle())
                            }
                        }
                        
                    } //end HStack
                    
                    Text("Current User: \(userName)")
                        .bold()
                        .modifier(gameTextStyle())

                    if isLoginSuccess {
                        NavigationLink {
                            MenuView(userName: userName)
                        } label: {
                            MenuItemView(text: "Play game")
                        }
                    }
                    
                    Spacer()
                    
                } //end VStack
            } //end ZStack
        } //end NavigationView
        
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
