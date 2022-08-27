//
//  PlayConfig.swift
//  MrFlipper
//
//  Created by Duong Minh Nhat on 27/08/2022.
//

import Foundation

//to control variables for a particular game play - belonging to GameView scope
struct PlayConfig {
    var firstFlipCardIndex: Int? = nil
    var secondFlipCardIndex: Int? = nil
    
    var score = 0;
    
    var noOfUnmatches = 0 //to track if reaching free unmatches yet
    var noOfMatches = 0 //to identify win condition
    
    //to display win/lose modal after users win/lose
    var showWinModal = false
    var showLoseModal = false
    
    var timeRemaining = Constants.totalTime
    
    mutating func reset() {
        resetFlippedCardIndex()
        
        //reset time
        timeRemaining = Constants.totalTime
        
        //reset score
        score = 0
        
        //reset others stats
        noOfUnmatches = 0
        noOfMatches = 0
    }
    
    mutating func resetFlippedCardIndex() {
        //reset card index
        firstFlipCardIndex = nil
        secondFlipCardIndex = nil
    }
}
