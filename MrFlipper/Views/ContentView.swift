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
    
    @State var rotation: Double = 0
    
    var body: some View {
        VStack
        {
            HStack {
                LazyVGrid(columns: columns){
                    //MARK: - CARD DISPLAY ON SCREEN
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
    
    //MARK: - FLIP FUNCTION
    func flipCard(_ card: Card) {
        //get index of the actual card of the card array
        let cardIndex = index(of: card)
        
        if cardIndex != nil {
            cards[cardIndex!].isFlipped.toggle()
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
