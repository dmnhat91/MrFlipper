/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Duong Minh Nhat
  ID: s3715125
  Created  date: 27/08/2022
  Last modified: 29/08/2022
  Acknowledgement: None
*/

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
    
    var timeRemaining: Int
    
    mutating func reset(resetTime: Int) {
        resetFlippedCardIndex()
        
        //reset time
        timeRemaining = resetTime
        
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
