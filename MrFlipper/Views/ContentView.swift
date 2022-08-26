//
//  ContentView.swift
//  MrFlipper
//
//  Created by Duong Minh Nhat on 23/08/2022.
//

import SwiftUI

struct ContentView: View {
    
    let adaptiveStat = 80.0
    
    @State var cards = [Card(imageName: "apple"), Card(imageName: "bell"), Card(imageName: "cherry"), Card(imageName: "clover")]
    
    private var columns: [GridItem] {
            return [
                .init(.adaptive(minimum: adaptiveStat))
            ]
        }
    
    var body: some View {
        VStack
        {
            HStack {
                LazyVGrid(columns: columns){
                    ForEach(cards){ card in
                        CardView(card: card)
                            .onTapGesture {
                                let cardIndex = cards.firstIndex(where: {$0 == card})
                                
                                if cardIndex != nil {
                                    cards[cardIndex!].isFlipped = true
                                }
                            }
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
