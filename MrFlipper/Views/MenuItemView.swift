//
//  MenuItemView.swift
//  MrFlipper
//
//  Created by Duong Minh Nhat on 28/08/2022.
//

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
