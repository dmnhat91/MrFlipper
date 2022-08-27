//
//  GameView.swift
//  MrFlipper
//
//  Created by Duong Minh Nhat on 27/08/2022.
//

import SwiftUI

struct GameView: View {
    //MARK: - GAME STATIC DATA
    let pointMinus = 3 //unmatched will deduct 3 pnts
    let pointAdd = 10 //match will add 10 pnts
    
    private var columns: [GridItem] {
            return [
                .init(.adaptive(minimum: gameConfig.adaptiveStat))
            ]
        }
    
    @State var gameConfig: GameConfig
    @State var playConfig = PlayConfig()
    
    //MARK: - MAIN LOGIC
    var body: some View {
        
        ZStack {
            VStack
            {
                //MARK: - GAME INFO AND SCORE
                HStack {
                    Text("Username: \(gameConfig.userName)")
                        .modifier(gameTextStyle())
                    Spacer()
                }
                
                HStack {
                    Text("Timer: \(gameConfig.totalTime)s")
                    Spacer()
                    Text("Score: \(playConfig.score)")
                }.modifier(gameTextStyle())
                
                HStack {
                    Text("Number of free moves left: \(gameConfig.noOfFreeUnmatches - playConfig.noOfUnmatches)")
                }.modifier(gameTextStyle())
                
                //MARK: - CARDS DISPLAY
                HStack {
                    LazyVGrid(columns: columns){
                        //MARK: - CARD DISPLAY ON SCREEN
                        ForEach(gameConfig.cards){ card in
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
            .blur(radius: playConfig.showWinModal ? 5 : 0 , opaque: false)
            
            if playConfig.showWinModal {
                WinModalView(score: playConfig.score)
            }
            
        } //end main ZStack
    }
    
    //MARK: - FLIP FUNCTION
    func performFlipCardProcess(_ card: Card) {
        //get index of the actual card of the card array
        let cardIndex = index(of: card)
        
        if cardIndex != nil {
            //only flip the card up - user does not allow to flip down
            if !gameConfig.cards[cardIndex!].isFlipped {
                flipCard(cardIndex: cardIndex)
                
                if playConfig.firstFlipCardIndex == nil {
                    playConfig.firstFlipCardIndex = cardIndex
                    
                } else if playConfig.secondFlipCardIndex == nil {
                    playConfig.secondFlipCardIndex = cardIndex
                    
                    // match check
                    checkMatch()
                }
            }
        }
    }
    
    func flipCard(cardIndex: Int?) {
        //reset card rotation (as rotation increases each flip)
        if gameConfig.cards[cardIndex!].rotation == 360 {
            gameConfig.cards[cardIndex!].rotation = 0
        }
        
        performCardFlipAnimation(cardIndex: cardIndex)
        
        gameConfig.cards[cardIndex!].isFlipped.toggle()
    }
    
    func index(of card: Card) -> Int? {
        gameConfig.cards.firstIndex(where: {$0 == card})
    }
    
    //animation flipping effect
    func performCardFlipAnimation(cardIndex: Int?) {
        for _ in 1...60 {
            withAnimation(Animation.linear(duration: 0.3)) {
                gameConfig.cards[cardIndex!].rotation += 3 //3*60 = 180 degrees
            }
        }
    }
    
    //MARK: - CARD MATCH LOGICS
    func checkMatch() {
        if gameConfig.cards[playConfig.firstFlipCardIndex!].imageName == gameConfig.cards[playConfig.secondFlipCardIndex!].imageName {
            
            //if cards are matched
            
            //increment match no
            playConfig.noOfMatches += 1
            
            //add points
            addScore(value: pointAdd)
            
            //fade cards
            fadeCard(cardIndex: playConfig.firstFlipCardIndex)
            fadeCard(cardIndex: playConfig.secondFlipCardIndex)
            
            //check win
            checkWin()
            
            playConfig.resetFlippedCardIndex()
        } else
        {
            //if cards are not matched
            
            //increment noOfUnmatch capped to noOfFreeUnmatches
            if playConfig.noOfUnmatches < gameConfig.noOfFreeUnmatches {
                playConfig.noOfUnmatches += 1
            } else { //noOfUnmatches >= noOfFreeUnmatches
                //minus point if unmatched
                subtractScore(value: pointMinus)
            }
            
            
            // unflip cards after delaying some time
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.35) {
                //unflip the card
                flipCard(cardIndex: playConfig.firstFlipCardIndex)
                flipCard(cardIndex: playConfig.secondFlipCardIndex)
                
                playConfig.resetFlippedCardIndex()
            }
        }
    }
    
    // card fading effecy
    func fadeCard(cardIndex: Int?){
        withAnimation(.linear(duration: 1)){
            gameConfig.cards[cardIndex!].opacity = 0
        }
    }
    
    // MARK: - Reset cards logics
    func resetCards() {
        resetGameStats()
        
        //reset all cards back to original state
        for i in 0...gameConfig.cards.count-1 {
            gameConfig.cards[i].isFlipped = false
            gameConfig.cards[i].rotation = 0
            gameConfig.cards[i].opacity = 1
        }
    }
    
    // MARK: - SCORE MODIFICATION FUNC
    func addScore(value: Int) {
        playConfig.score += value
    }
    
    func subtractScore(value: Int) {
        playConfig.score -= value
        if playConfig.score < 0 {
            playConfig.score = 0
        }
    }
    
    //MARK: - Reset timer
    // ???: add code here
    
    func resetGameStats() {
        playConfig.reset()
    }

    //MARK: - CHECK WIN
    func checkWin() {
        if playConfig.noOfMatches == gameConfig.cards.count/2 {
            playConfig.showWinModal = true
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        let gameConfig = GameConfig(cards: gameCards)
        GameView(gameConfig: gameConfig)
    }
}
