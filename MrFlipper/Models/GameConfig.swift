//
//  GameConfig.swift
//  MrFlipper
//
//  Created by Duong Minh Nhat on 27/08/2022.
//

import Foundation


// to control general game settings - belonging to whole game scope
struct GameConfig {
//    var userName = "dmnhat91"
    var adaptiveStat = 60.0
    var cards = gameCards
    
//    var totalTime = 120; //to identify lose condition
    
    var noOfFreeUnmatches = 5 //number of unmatches that are not deducted points
    
    mutating func resetCards() {
        //reset all cards back to original state
        for i in 0...cards.count-1 {
            cards[i].isFlipped = false
            cards[i].rotation = 0
            cards[i].opacity = 1
        }
        
        // randomize the cards within the array
        cards.shuffle()
    }
}
