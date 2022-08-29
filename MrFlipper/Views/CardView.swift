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

struct CardView: View {
    let card: Card
    
    var body: some View {
        
        Image(card.isFlipped ? card.imageName : "app-logo")
            .resizable()
            .frame(minWidth: 70, idealWidth: 100, maxWidth: 120, minHeight: 140, idealHeight: 200, maxHeight: 240)
            .scaledToFit()
            .border(.black)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card(imageName: "apple"))
            .previewLayout(.sizeThatFits)
    }
}
