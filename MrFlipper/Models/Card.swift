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


struct Card: Identifiable, Equatable {
    var id = UUID()
    var isFlipped: Bool = false
    var imageName: String
    
    var rotation: Double = 0 //for animating flipping effect
    var opacity: Double = 1 //for animating fadding effect
}
