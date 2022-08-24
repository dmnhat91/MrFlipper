//
//  ContentView.swift
//  MrFlipper
//
//  Created by Duong Minh Nhat on 23/08/2022.
//

import SwiftUI

struct ContentView: View {
    
    let cards = ["apple", "bell", "cherry", "clover"]
    
    var body: some View {
    
        HStack {
            ForEach(cards, id:\.self){ cardName in
                CardView(cardImageName: cardName)
            }

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
