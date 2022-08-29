//
//  InfoView.swift
//  MrFlipper
//
//  Created by Duong Minh Nhat on 29/08/2022.
//

import SwiftUI

struct InfoView: View {
    var body: some View {
        ZStack {
            ColorConstants.themeColor
            VStack(alignment: .center, spacing: 10) {
                Image("app-logo-transparent")
                    .offset(y: -100)
                    .padding(.bottom, -200)

              Spacer()

              Form {
                Section(header: Text("How To Play")) {
                    Text("This is a card flip game. You need to match 10 pairs of cards to win.")
                    Text("There are 3 modes: Easy, Medium, Difficult.")
                    Text("A match will bonus:\n- 10 points (easy mode)\n- 20 points (medium mode)\n- 30 points (hard mode)")
                    Text("However, an unmatch will deduct:\n- 3 points (easy mode)\n- 10 points (medium mode)\n- 20 points (hard mode)")
                    Text("When game starts, you have 5 free moves without points deduction when unmatch.")
                    Text("Time: \n- 90 seconds (easy mode) \n- 60 seconds (medium mode) \n- 30 seconds (hard mode)")
                    Text("To achieve badge: \n- bronze (50 points)\n- silver (100 points)\n- gold (200 points)\n- diamond (290 points)")
                }
                  Section(header: Text("Application Information")) {
                      HStack {
                        Text("App Name")
                        Spacer()
                        Text("Mr Flipper")
                      }
                      HStack {
                        Text("Course")
                        Spacer()
                        Text("COSC2659")
                      }
                      HStack {
                        Text("Year Published")
                        Spacer()
                        Text("2022")
                      }
                      HStack {
                        Text("Location")
                        Spacer()
                        Text("Saigon South Campus")
                      }
                      HStack {
                        Text("Author")
                        Spacer()
                        Text("Duong Minh Nhat")
                      }
                      HStack {
                        Text("Student ID")
                        Spacer()
                        Text("S3715125")
                      }
                }
              }
              .font(.system(.body, design: .rounded))
            }
            .padding(.top, 40)
        }.onAppear {
            playSound(sound: "bg-music", type: "mp3")
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
