//
//  GameView.swift
//  MrFlipper
//
//  Created by Duong Minh Nhat on 27/08/2022.
//

import SwiftUI

struct GameView: View {
    let userName: String
    let totalTime: Int
    let pointMinus: Int //points when unmatched will deduct
    let pointAdd: Int //points when a match will add
    
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var isLoseMusicPlay = false
    
    private var columns: [GridItem] {
            return [
                .init(.adaptive(minimum: gameConfig.adaptiveStat))
            ]
        }
    
    @State var gameConfig = GameConfig()
    @State var playConfig : PlayConfig
    
    //MARK: - MAIN LOGIC
    var body: some View {
        
        ZStack {
            ColorConstants.themeColor
                .opacity(0.5)
                .edgesIgnoringSafeArea(.all)
            
            VStack
            {
                //MARK: - GAME INFO AND SCORE
                HStack {
                    Text("Username: \(userName)")
                        .bold()
                        .modifier(gameTextStyle())
                    Spacer()
                }
                
                HStack {
                    Text("Timer: \(playConfig.timeRemaining)s")
                        .bold()
                        .onReceive(timer) { _ in
                            if playConfig.timeRemaining > 0 {
                                playConfig.timeRemaining -= 1
                            } else { //when timeRemaning = 0
                                //player loses
                                performLoseAction()
                            }
                        }
                    Spacer()
                    Text("Score: \(playConfig.score)")
                        .bold()
                }.modifier(gameTextStyle())
                
                HStack {
                    Text("Number of free moves left: \(gameConfig.noOfFreeUnmatches - playConfig.noOfUnmatches)")
                        .bold()
                }.modifier(gameTextStyle())
                
                //MARK: - CARDS DISPLAY
                ScrollView {
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
                }
                
                Button("Reset") {
                    resetFullGame()
                }
                
                Spacer()
            } //end VStack
            .blur(radius: playConfig.showWinModal ? 5 : 0 , opaque: false)
            
            if playConfig.showWinModal {
                ResultModalView(displayText: "YOU WON", isWin: true, totalTime: totalTime, playConfig: $playConfig, gameConfig: $gameConfig)
            } else if playConfig.showLoseModal {
                ResultModalView(displayText: "YOU LOST. TIME'S UP!!", isWin: false, totalTime: totalTime, playConfig: $playConfig, gameConfig: $gameConfig)
                    .onDisappear(perform: {
                        isLoseMusicPlay = false
                    })
            }
            
        } //end main ZStack
        .onAppear(perform: {
            // randomize the cards within the array
            gameConfig.cards.shuffle()
        })
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
        
        playSound(sound: "card-flip-sound", type: "mp3")
        
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
            
            //play sound
            playSound(sound: "card-match-music", type: "mp3")
            
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
            
            //play sound
            playSound(sound: "card-unmatch-music", type: "mp3")
            
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
    func resetFullGame() {
        resetGameStats()
        
        gameConfig.resetCards()
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
        playConfig.reset(resetTime: totalTime)
    }

    //MARK: - CHECK WIN
    func checkWin() {
        //number of cards/2 = total pairs of cards
        if playConfig.noOfMatches == gameConfig.cards.count/2 {
            playSound(sound: "game-win-music", type: "mp3")
            
            playConfig.showWinModal = true
            
            updateUserResult()
        }
    }
    
    //MARK: - LOSE ACTION
    func performLoseAction() {
        if !isLoseMusicPlay {
            playSound(sound: "game-lose-music", type: "mp3")
            isLoseMusicPlay = true
            
            updateUserResult()
        }
        
        playConfig.showLoseModal = true
    }
    
    //MARK: - UPDATE USER HIGHSCORE AND BADGE
    func updateUserResult() {
        var usersData = getUserDict()
        var currentUser = usersData[userName]
        if currentUser != nil {
            if currentUser!.highScore < playConfig.score {
                currentUser!.highScore = playConfig.score
                currentUser!.badge = calculateBadge(score: playConfig.score)
            }
            usersData[userName] = currentUser
            saveUserDict(value: usersData)
        }
    }
    
    func calculateBadge(score: Int) -> String {
        if score >= 50 && score < 100 {
            return Constants.bronzeBadgeName
        } else if score >= 100 && score < 200 {
            return Constants.silverBadgeName
        } else if score >= 200 && score < 290 {
            return Constants.goldBadgeName
        } else {
            return Constants.diamondBadgeName
        }
    }
}

struct GameView_Previews: PreviewProvider {
    
    static var previews: some View {
//        let gameConfig = GameConfig(cards: gameCards)
//        GameView(gameConfig: gameConfig)
        let playConfig = PlayConfig(timeRemaining: Constants.totalTime)
        
        GameView(userName: "minhnhat", totalTime: Constants.totalTime, pointMinus: Constants.pointsEasyModeDeduct, pointAdd: Constants.pointsEasyModeAdd, playConfig: playConfig)
    }
}
