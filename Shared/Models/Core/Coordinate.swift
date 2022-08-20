//
//  CoordinateModel.swift
//  PirateWar (iOS)
//
//  Created by Minh Pham Cong on 12/08/2022.
//

import Foundation

// Coordinate represents a pair (x, y) value from the playing board
struct Coordinate: Hashable {
    var x: Int = 0
    var y: Int = 0

    static var zero = Coordinate(x: 0, y: 0)
    static var unset = Coordinate(x: -1, y: -1)

    static func == (c1: Coordinate, c2: Coordinate) -> Bool {
        return c1.x == c2.x && c1.y == c2.y
    }

    static func != (c1: Coordinate, c2: Coordinate) -> Bool {
        return c1.x != c2.x || c1.y != c2.y
    }
}

extension Coordinate: CustomStringConvertible {
    var description: String {
        return "(\(x), \(y))"
    }

    func increment(x: Int, y: Int) -> Coordinate {
        let newOrigin = Coordinate(x: self.x + x, y: self.y + y)
        return newOrigin
    }
}
