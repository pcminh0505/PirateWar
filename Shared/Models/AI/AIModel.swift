//
//  AIModel.swift
//  PirateWar (iOS)
//
//  Created by Minh Pham on 20/08/2022.
// https://github.com/Oliver-Binns/Battleships-AI---Swift-Playground

import Foundation

// Future improvement: Add .sunk notification to optimize prediction
enum Feedback {
    case miss
    case hit
    case sunk
}

protocol AIModel {
    init()
    
    mutating func nextMove() -> Coordinate
    
    mutating func feedback(success: Bool)
}
