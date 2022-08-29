//
//  LeaderboardItemView.swift
//  MrFlipper
//
//  Created by Duong Minh Nhat on 28/08/2022.
//

import SwiftUI

struct LeaderboardItemView: View {
    let username: String
    let score: Int
    let imageName: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 30)
            .fill(ColorConstants.whiteBlackColor)
            .frame(height: 60)
            .border(.black, width: 2)
            .padding([.leading, .trailing], 5)
            .padding([.top, .bottom], 5)
            .overlay(
                HStack {
                    Text("User: \(username) - \(score) pnts")
                        .foregroundColor(ColorConstants.darkTextColorTheme)
                        .bold()
                        .padding(.leading, 10)
                        .clipped()
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
        LeaderboardItemView(username: "dmnhat", score: 120, imageName: "bronze")
            .previewLayout(.sizeThatFits)
        LeaderboardItemView(username: "hawky99", score: 120, imageName: "diamond")
            .previewLayout(.sizeThatFits)
        
    LeaderboardItemView(username: "hawky99", score: 120, imageName: "")
        .previewLayout(.sizeThatFits)
    }
}
