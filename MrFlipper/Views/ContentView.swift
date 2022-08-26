//
//  ContentView.swift
//  MrFlipper
//
//  Created by Duong Minh Nhat on 23/08/2022.
//

import SwiftUI

struct ContentView: View {
    
    let adaptiveStat = 80.0
    
    @State var cards : [Card]
    
    private var columns: [GridItem] {
            return [
                .init(.adaptive(minimum: adaptiveStat))
            ]
        }
    
    //MARK: - MAIN LOGIC
    var body: some View {
        VStack
        {
            HStack {
                LazyVGrid(columns: columns){
                    //MARK: - CARD DISPLAY ON SCREEN
                    ForEach(cards){ card in
                        CardView(card: card)
                            .rotation3DEffect(.degrees(card.rotation), axis: (x: 0, y: 1, z: 0))
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
            
            //reset card rotation (as rotation increases each flip)
            if cards[cardIndex!].rotation == 360 {
                cards[cardIndex!].rotation = 0
            }
            
            //animation flipping effect
            for i in 1...60 {
                withAnimation(Animation.linear(duration: 0.3)) {
                    cards[cardIndex!].rotation += 3 //3*60 = 180 degrees
                }
                
                if i == 30 {//at 90 degrees
                    cards[cardIndex!].isFlipped.toggle()
                }
            }
            
        }
    }
    
    func index(of card: Card) -> Int? {
        cards.firstIndex(where: {$0 == card})
    }
    

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(cards: gameCards)
    }
}
