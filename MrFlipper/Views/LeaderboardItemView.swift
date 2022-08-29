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

struct LeaderboardItemView: View {
    let username: String
    let score: Int
    let imageName: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 30)
            .fill(ColorConstants.whiteBlackColor)
            .frame(height: 90)
            .border(.black, width: 2)
            .padding([.leading, .trailing], 5)
            .padding([.top, .bottom], 5)
            .overlay(
                HStack {
                    Text("\(username)\nScore: \(score) pnts")
                        .foregroundColor(ColorConstants.darkTextColorTheme)
                        .bold()
                        .padding(.leading, 10)
                        .clipped()
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    Text("Badge \(imageName): ")
                        .foregroundColor(ColorConstants.darkTextColorTheme)
                        .bold()
                    if imageName == "" {
                        Text("none")
                            .foregroundColor(ColorConstants.darkTextColorTheme)
                            .bold()
                            .padding(.trailing, 10)
                    } else {
                        Image(imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 50)
                            .padding(.trailing, 5)
                    }
                 }
            )
    }
}

struct LeaderboardItemView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardItemView(username: "minhnhat", score: 70, imageName: "bronze")
            .previewLayout(.sizeThatFits)
        LeaderboardItemView(username: "hawky99", score: 120, imageName: "diamond")
            .previewLayout(.sizeThatFits)
        
    LeaderboardItemView(username: "hawky99", score: 120, imageName: "")
        .previewLayout(.sizeThatFits)
    }
}
