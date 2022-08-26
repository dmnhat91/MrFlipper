//
//  Card.swift
//  MrFlipper
//
//  Created by Duong Minh Nhat on 25/08/2022.
//

import Foundation


struct Card: Identifiable, Equatable {
    var id = UUID()
    var isFlipped: Bool = false
    var imageName: String
    
    var rotation: Double = 0 //for animating flipping effect
}
