//
//  UsernameInputView.swift
//  MrFlipper
//
//  Created by Duong Minh Nhat on 28/08/2022.
//

import SwiftUI

struct UserLoginView: View {
//    let isUserLogin: Bool //user can login OR register
    
    @Binding var usernameInput: String
    @Binding var isLoginSuccess: Bool
    
    @State private var username = ""
//    @State private var isUserExisted = false
    @State private var isValidated = false
    
    @State private var usersStore: [String:Int] = [:]
    
    var body: some View {
        VStack {
//            if isUserLogin {
//                Text("user login".uppercased())
//                    .bold()
//                    .modifier(gameTextStyle())
//                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
//            } else {
//                Text("user registration".uppercased())
//                    .bold()
//                    .modifier(gameTextStyle())
//                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
//            }
            Text("user login".uppercased())
                .bold()
                .modifier(gameTextStyle())
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)

            
            HStack {
                Text("Username:")
                    .bold()
                    .modifier(gameTextStyle())
                TextField(
                    "Enter username",
                    text: $username
                )
                .onSubmit {
                    //when user press enters, perform login
//                    validate(name: username)
                    performLogin(name: username)
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
            
//            if isValidated {
//                if isUserLogin && username != "" {
//                    // if user login and enters unexisted user
//                    if !isUserExisted {
//                        //login fail logic
//                        Text("User is not existed!!")
//                            .bold()
//                            .foregroundColor(.red)
//                            .onAppear {
//                                isLoginSuccess = false
//
//                                //reset
//                                usernameInput = ""
//                            }
//                    } else {
//                        //login success logic
//                        Text("LOGIN SUCCESS")
//                            .bold()
//                            .foregroundColor(ColorConstants.darkTextColorTheme)
//                            .onAppear {
//                                isLoginSuccess = true
//
//                                usernameInput = username
//                            }
//                    }
//                } else if !isUserLogin && username != "" {
//                    // if user registers
//                    if isUserExisted {
//                        //???: register fail code here
//                        Text("User is already existed existed!!")
//                            .bold()
//                            .foregroundColor(.red)
//                    } else {
//                        Text("REGISTER SUCCESS WITH USERNAME: \(username)")
//                            .bold()
//                            .foregroundColor(ColorConstants.darkTextColorTheme)
//
//                    }
//                } //endif isUserLogin
//            } //endif isValidated
            
            if isValidated {
                if isLoginSuccess {
                    //login success logic
                    Text("LOGIN SUCCESS")
                        .bold()
                        .foregroundColor(ColorConstants.darkTextColorTheme)
                } else {
                    Text("User is not existed!!")
                        .bold()
                        .foregroundColor(.red)
                }
                
            } //endif isValidated
            
        } //end VStack

    }
    
    func validate(name: String) -> Bool {
        if name != "" && usersStore.keys.contains(name) || name == "Nhat" {
            isValidated = true
            return true
        }
        isValidated = true
        return false
    }
    
    func performLogin(name: String) {
        usersStore = UserDefaults.standard.object(forKey: "users") as? [String:Int] ?? [:]
        
        if validate(name: username) {
            isLoginSuccess = true
            usernameInput = username
//            isUserExisted = true //user existed
        } else {
            isLoginSuccess = false
//            isUserExisted = false //user not existed
            
            //reset
            usernameInput = ""
        }
    }
    
}

struct UsernameInputView_Previews: PreviewProvider {
    @State static var usernameInput = ""
    @State static var isLoginSuccess = false
    
    static var previews: some View {
        UserLoginView(usernameInput: $usernameInput, isLoginSuccess: $isLoginSuccess).previewLayout(.sizeThatFits)
    }
}
