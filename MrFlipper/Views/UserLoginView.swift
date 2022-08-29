/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Duong Minh Nhat
  ID: s3715125
  Created  date: 27/08/2022
  Last modified: 29/08/2022
  Acknowledgement: None
*/

import SwiftUI

struct UserLoginView: View {
    @Binding var usernameInput: String
    @Binding var isLoginSuccess: Bool
    
    @State private var username = ""
    @State private var isValidated = false
    
    @State private var usersStore: [String:User] = [:]
    
    var body: some View {
        VStack {
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
        usersStore = getUserDict()
        
        if validate(name: username) {
            isLoginSuccess = true
            usernameInput = username
        } else {
            isLoginSuccess = false
            
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
