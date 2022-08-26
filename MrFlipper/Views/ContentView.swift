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
                                flipCard(card)
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
    
    func flipCard(_ card: Card) {
        let cardIndex = index(of: card)
        
        if cardIndex != nil {
            
            let isCardFlipped = cards[cardIndex!].isFlipped
            
            if isCardFlipped {
                cards[cardIndex!].isFlipped = false
            } else {
                cards[cardIndex!].isFlipped = true
            }
        }
    }
    
    func index(of card: Card) -> Int? {
        cards.firstIndex(where: {$0 == card})
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
