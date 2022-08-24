//
//  CardView.swift
//  MrFlipper
//
//  Created by Duong Minh Nhat on 24/08/2022.
//

import SwiftUI

struct CardView: View {
    let cardImageName: String
    
    var body: some View {
        Image(cardImageName)
            .resizable()
            .frame(minWidth: 70, idealWidth: 100, maxWidth: 120, minHeight: 140, idealHeight: 200, maxHeight: 240)
            .scaledToFit()
            .border(.black)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(cardImageName: "apple")
            .previewLayout(.sizeThatFits)
    }
}
