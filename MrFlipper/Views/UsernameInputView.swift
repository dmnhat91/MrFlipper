//
//  UsernameInputView.swift
//  MrFlipper
//
//  Created by Duong Minh Nhat on 28/08/2022.
//

import SwiftUI

struct UsernameInputView: View {
    let isUserLogin: Bool //user can login OR register
    @State private var username: String = ""
    @State private var isUserExisted = false
    @State private var isValidated = false
    
    var body: some View {
        VStack {
            if isUserLogin {
                Text("user login".uppercased())
                    .bold()
                    .modifier(gameTextStyle())
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            } else {
                Text("user registration".uppercased())
                    .bold()
                    .modifier(gameTextStyle())
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            }
            
            
            HStack {
                Text("Username:")
                    .bold()
                    .modifier(gameTextStyle())
                TextField(
                    "Enter username",
                    text: $username
                )
                .onSubmit {
                    //when user press enters, perform validate
                    validate(name: username)
                }
                // when user reenter - no longer validate
                .onChange(of: username, perform: { _ in
                    isValidated = false
                })
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .border(.secondary)
                .border(ColorConstants.darkTextColorTheme, width: 2)
                .padding(.trailing, 5)
                .multilineTextAlignment(.center)
            } //end HStack
            
            if isValidated {
                if isUserLogin && username != "" {
                    // if user login and enters unexisted user
                    if !isUserExisted {
                        Text("User is not existed!!")
                            .bold()
                            .foregroundColor(.red)
                    } else {
                        // ???: login success code here
                    }
                } else if !isUserLogin && username != "" {
                    // if user registers
                    if isUserExisted {
                        Text("User is already existed existed!!")
                            .bold()
                            .foregroundColor(.red)
                    } else {
                        // ???: register success code here
                    }
                } //endif isUserLogin
            } //endif isValidated
        } //end VStack

    }
    
    func validate(name: String) {
        //???: logic validate here
        if name == "Nhat" {
            isUserExisted = true //user existed
        } else {
            isUserExisted = false //user not existed
        }
        
        isValidated = true
    }
    
    
}

struct UsernameInputView_Previews: PreviewProvider {
    static var previews: some View {
        UsernameInputView(isUserLogin: true).previewLayout(.sizeThatFits)
    }
}
