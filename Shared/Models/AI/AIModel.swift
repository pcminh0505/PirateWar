//
//  AIModel.swift
//  PirateWar (iOS)
//
//  Created by Minh Pham on 20/08/2022.
// https://github.com/Oliver-Binns/Battleships-AI---Swift-Playground

import Foundation

protocol AIModel{
    init()
    
    mutating func nextMove() -> Coordinate
    
    mutating func feedback(success: Bool)
}
