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
    
    @State var firstFlipCardIndex: Int? = nil
    @State var secondFlipCardIndex: Int? = nil
    
    //MARK: - MAIN LOGIC
    var body: some View {
        VStack
        {
            HStack {
                LazyVGrid(columns: columns){
                    //MARK: - CARD DISPLAY ON SCREEN
                    ForEach(cards){ card in
                        CardView(card: card)
                            .opacity(card.opacity)
                            .rotation3DEffect(.degrees(card.rotation), axis: (x: 0, y: 1, z: 0))
                            .onTapGesture {
                                performFlipCardProcess(card)
                            }
                    }
                }

            }
            .padding([.leading, .trailing], 5)
            
            Button("Reset") {
                resetCards()
            }
        } //end VStack
        
    }
    
    //MARK: - FLIP FUNCTION
    func performFlipCardProcess(_ card: Card) {
        //get index of the actual card of the card array
        let cardIndex = index(of: card)
        
        if cardIndex != nil {
            //only flip the card up - user does not allow to flip down
            if !cards[cardIndex!].isFlipped {
                flipCard(cardIndex: cardIndex)
                
                if firstFlipCardIndex == nil {
                    firstFlipCardIndex = cardIndex
                    
                } else if secondFlipCardIndex == nil {
                    secondFlipCardIndex = cardIndex
                    
                    //match check logics
                    // ???: add logic here
                    checkMatch()
                    
                }
            }
        }
    }
    
    func flipCard(cardIndex: Int?) {
        //reset card rotation (as rotation increases each flip)
        if cards[cardIndex!].rotation == 360 {
            cards[cardIndex!].rotation = 0
        }
        
        performCardFlipAnimation(cardIndex: cardIndex)
        
        cards[cardIndex!].isFlipped.toggle()
    }
    
    func index(of card: Card) -> Int? {
        cards.firstIndex(where: {$0 == card})
    }
    
    //animation flipping effect
    func performCardFlipAnimation(cardIndex: Int?) {
        for _ in 1...60 {
            withAnimation(Animation.linear(duration: 0.3)) {
                cards[cardIndex!].rotation += 3 //3*60 = 180 degrees
            }
        }
    }
    
    //MARK: - CARD MATCH LOGICS
    func checkMatch() {
        if cards[firstFlipCardIndex!].imageName == cards[secondFlipCardIndex!].imageName {
            
            //if cards are matched
            // ???: Add matched logics here
            
            //fade cards
            fadeCard(cardIndex: firstFlipCardIndex)
            fadeCard(cardIndex: secondFlipCardIndex)
            
            resetFlippedCardIndex()
        } else
        {
            //if cards are not matched
            
            //Add unmatch logics here - minus point
            // ???: add logic here
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.35) {
                //unflip the card
                flipCard(cardIndex: firstFlipCardIndex)
                flipCard(cardIndex: secondFlipCardIndex)
                
                resetFlippedCardIndex()
            }
        }
    }
    
    func resetFlippedCardIndex(){
        //reset card index
        firstFlipCardIndex = nil
        secondFlipCardIndex = nil
    }
    
    // card fading effecy
    func fadeCard(cardIndex: Int?){
        withAnimation(.linear(duration: 1)){
            cards[cardIndex!].opacity = 0
        }
    }
    
    // MARK: - Reset cards logics
    func resetCards() {
        resetFlippedCardIndex()
        
        //reset all cards back to original state
        for i in 0...cards.count-1 {
            cards[i].isFlipped = false
            cards[i].rotation = 0
            cards[i].opacity = 1
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(cards: gameCards)
    }
}
