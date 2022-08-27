//
//  GameView.swift
//  MrFlipper
//
//  Created by Duong Minh Nhat on 27/08/2022.
//

import SwiftUI

struct GameView: View {
    let userName = "dmnhat91"
    let adaptiveStat = 80.0
    
    let pointMinus = 3 //unmatched will deduct 3 pnts
    let pointAdd = 10 //match will add 10 pnts
    let noOfFreeUnmatches = 3 //number of unmatches that are not deducted points
    
    @State var cards : [Card]
    
    private var columns: [GridItem] {
            return [
                .init(.adaptive(minimum: adaptiveStat))
            ]
        }
    
    @State var firstFlipCardIndex: Int? = nil
    @State var secondFlipCardIndex: Int? = nil
    
    @State var score = 0;
    let totalTime = 120; //to identify lose condition
    
    @State var noOfUnmatches = 0 //to track if reaching free unmatches yet
    @State var noOfMatches = 0 //to identify win condition
    
    //MARK: - MAIN LOGIC
    var body: some View {
        VStack
        {
            //MARK: - USER INFO AND SCORE
            HStack {
                Text("Username: \(userName)")
                    .modifier(gameTextStyle())
                Spacer()
            }
            
            HStack {
                Text("Timer: \(totalTime)s")
                Spacer()
                Text("Score: \(score)")
            }.modifier(gameTextStyle())
            
            HStack {
                Text("Number of free moves left: \(noOfFreeUnmatches - noOfUnmatches)")
            }.modifier(gameTextStyle())
            
            //MARK: - CARDS DISPLAY
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
            
            Spacer()
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
                    
                    // match check
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
            
            //add points
            addScore(value: pointAdd)
            
            //fade cards
            fadeCard(cardIndex: firstFlipCardIndex)
            fadeCard(cardIndex: secondFlipCardIndex)
            
            resetFlippedCardIndex()
        } else
        {
            //if cards are not matched
            
            //increment noOfUnmatch capped to noOfFreeUnmatches
            if noOfUnmatches < noOfFreeUnmatches {
                noOfUnmatches += 1
            } else { //noOfUnmatches >= noOfFreeUnmatches
                //minus point if unmatched
                subtractScore(value: pointMinus)
            }
            
            
            // unflip cards after delaying some time
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
        resetGameStats()
        
        //reset all cards back to original state
        for i in 0...cards.count-1 {
            cards[i].isFlipped = false
            cards[i].rotation = 0
            cards[i].opacity = 1
        }
    }
    
    // MARK: - SCORE MODIFICATION FUNC
    func addScore(value: Int) {
        score += value
    }
    
    func subtractScore(value: Int) {
        score -= value
        if score < 0 {
            score = 0
        }
    }
    
    func resetGameStats() {
        resetFlippedCardIndex()
        
        //reset timer
        // ???: add code here
        
        //reset score
        score = 0
        
        //reset others stats
        noOfUnmatches = 0
        noOfMatches = 0
    }

}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(cards: gameCards)
    }
}
