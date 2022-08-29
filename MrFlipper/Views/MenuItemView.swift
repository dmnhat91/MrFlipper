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

struct MenuItemView: View {
    let text: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 30)
            .fill(ColorConstants.themeColor)
            .frame(height: 50)
//            .border(ColorConstants.darkTextColorTheme, width: 2)
            .padding([.leading, .trailing])
            .padding([.top, .bottom], 5)
            .overlay(
                HStack {
                    Text(text)
                        .foregroundColor(ColorConstants.darkTextColorTheme)
                        .bold()
                 }
            )
    }
}

struct MenuItemView_Previews: PreviewProvider {
    static var previews: some View {
        MenuItemView(text: "Easy")
            .previewLayout(.sizeThatFits)
    }
}
