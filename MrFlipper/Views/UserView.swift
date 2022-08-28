//
//  UserView.swift
//  MrFlipper
//
//  Created by Duong Minh Nhat on 28/08/2022.
//

import SwiftUI

struct UserView: View {
    @State var userName = "unknown"
    
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
                    Button(action: {
                        //???: insert add user logics here
                        print("User login")
                    }) {
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
                    
                    Button(action: {
                        //???: insert add user logics here
                        print("User added")
                    }) {
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
                
                NavigationLink {
                    //???: Enter logics here
                } label: {
                    MenuItemView(text: "Play game")
                }
                
                Spacer()
                
            } //end VStack
        } //end ZStack
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
