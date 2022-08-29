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

let cardNames = ["apple", "bell", "cherry", "clover", "bar", "melon", "money", "orange", "heart", "grape", "diamond", "horseshoe"]

var gameCards = generateCards()

//MARK: - CARD GEN
// prepare pair of cards content
func generateCards() -> [Card]{
    // declare an empty array
    var generatedCards = [Card]()
    
    // generate 10 pairs of cards
    for i in 0...9 {
        
        // create two new card objects
        let cardOne = Card(imageName: cardNames[i])
        let cardTwo = Card(imageName: cardNames[i])
        
        // add them to the array
        generatedCards += [cardOne, cardTwo]
    }
    
    // randomize the cards within the array
//    generatedCards.shuffle()
    
    // return the array
    return generatedCards
}
