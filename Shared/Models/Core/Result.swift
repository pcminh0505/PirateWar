//
//  Result.swift
//  PirateWar (iOS)
//
//  Created by Minh Pham on 21/08/2022.
//

import Foundation

struct Result {
    let turn: Int
    let seconds: Int
    let destroyedShips: Int
    let accuracy: Float
    let totalScore: Int

    init(turn: Int, seconds: Int, destroyedShips: Int, hitShot: Int) {
        self.turn = turn
        self.seconds = seconds
        self.destroyedShips = destroyedShips
        self.accuracy = Float(hitShot) / Float(turn)

        // Formula
        self.totalScore = max(((100 * destroyedShips - ((turn + (seconds / 60)))) * hitShot / turn), 0)
    }

    static var zero = Result(turn: 1, seconds: 0, destroyedShips: 0, hitShot: 0)
}
