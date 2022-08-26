//
//  ContentView.swift
//  MrFlipper
//
//  Created by Duong Minh Nhat on 23/08/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State var cards = [Card(imageName: "apple"), Card(imageName: "bell"), Card(imageName: "cherry"), Card(imageName: "clover")]
    
    var body: some View {
        VStack
        {
            HStack {
                LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]){
                    ForEach(cards){ card in
                        CardView(card: card)
                    }
                }

            }
            .padding([.leading, .trailing], 5)
            
            Button("Shuffle") {
                cards.shuffle()
            }
        } //end VStack
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
