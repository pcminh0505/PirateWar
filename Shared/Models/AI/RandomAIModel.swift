//
//  EasyAIModel.swift
//  PirateWar (iOS)
//
//  Created by Minh Pham on 20/08/2022.
// https://github.com/Oliver-Binns/Battleships-AI---Swift-Playground
// https://www.datagenetics.com/blog/december32011/

import Foundation

struct RandomAIModel: AIModel {
    private var attacked: [Coordinate] = []

    public init() { }

    private func getRandomCell() -> Coordinate {
        let x = Int(arc4random_uniform(10))
        let y = Int(arc4random_uniform(10))
        return Coordinate(x: x, y: y)
    }

    public mutating func nextMove() -> Coordinate {
        var origin = getRandomCell()
        while(attacked.contains(origin)) {
            origin = getRandomCell()
        }
        attacked.append(origin)
        return origin
    }

    public mutating func feedback(success: Bool) {
        // No feedback based
    }
}
