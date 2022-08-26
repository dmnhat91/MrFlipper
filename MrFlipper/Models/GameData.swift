//
//  GameData.swift
//  MrFlipper
//
//  Created by Duong Minh Nhat on 26/08/2022.
//

import Foundation

let cardNames = ["apple", "bell", "cherry", "clover"]

var gameCards = generateCards()

//MARK: - CARD GEN
// prepare pair of cards content
func generateCards() -> [Card]{
    // declare an empty array
    var generatedCards = [Card]()
    
    // generate 2 pairs of cards
    for i in 0...1 {
        
        // create two new card objects
        let cardOne = Card(imageName: cardNames[i])
        let cardTwo = Card(imageName: cardNames[i])
        
        print(cardOne)
        
        // add them to the array
        generatedCards += [cardOne, cardTwo]
    }
    
    // randomize the cards within the array
    generatedCards.shuffle()
    
    // return the array
    return generatedCards
}
