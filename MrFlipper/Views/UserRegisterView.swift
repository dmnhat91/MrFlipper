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

struct UserRegisterView: View {
    @State private var username = ""
    @State private var isValidated = false
    @State private var isRegisSuccess = false
    
    @State private var usersStore: [String:User] = [:]
    
    var body: some View {
        VStack {
            Text("user registration".uppercased())
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
                    //when user press enters, perform registration
                    performRegistration(name: username)
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
                if !isRegisSuccess {
                    Text("User is already existed!!")
                        .bold()
                        .foregroundColor(.red)
                } else {
                    Text("REGISTER SUCCESS WITH USERNAME: \(username)")
                        .bold()
                        .foregroundColor(.red)
                }
            } //endif isValidated
        } //end VStack
    }
    
    func performRegistration(name: String) {
        usersStore = getUserDict()

        if !validate(name: username) { //name should NOT exist in storage before registration
            
            addToStorage(name: name)
            
            isRegisSuccess = true
        } else {
            isRegisSuccess = false
        }
    }
    
    func validate(name: String) -> Bool {
        if name != "" && usersStore.keys.contains(name) {
            isValidated = true
            return true
        }
        isValidated = true
        return false
    }
    
    func addToStorage(name: String) {
        //capped to max users - if > max, remove the first user before register new one
        if usersStore.keys.count >= Constants.maxNoOfUsers {
            let firstKey = Array(usersStore)[0].key
            usersStore[firstKey] = nil
        }
        
        usersStore[name] = User(username: name) //highest score default to 0
        
        saveUserDict(value: usersStore)
        
        //[DEBUG]]
        print(usersStore)
    }
    
}

struct UserRegisterView_Previews: PreviewProvider {
    static var previews: some View {
        UserRegisterView()
    }
}
