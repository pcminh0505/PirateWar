//
//  SuperEasyAIModel.swift
//  PirateWar (iOS)
//
//  Created by Minh Pham on 20/08/2022.
// https://github.com/Oliver-Binns/Battleships-AI---Swift-Playground
// https://www.datagenetics.com/blog/december32011/

struct SequentialAIModel: AIModel {
    private var turns = 0

    public init() { }

    public mutating func feedback(success: Bool) {
    }

    public mutating func nextMove() -> Coordinate {
        let x = turns % 10
        let y = Int(turns / 10)
        turns += 1
        return Coordinate(x: x, y: y)
    }

}
