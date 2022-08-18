//
//  Ocean.swift
//  PirateWar (iOS)
//
//  Created by Minh Pham on 12/08/2022.
//

import Foundation

// Ocean represents a n*m board in Coordinate space with the origin at (0,0)
struct Ocean {
    var numCols: Int
    var numRows: Int
    private var origin: Coordinate = .zero

    init(numCols: Int, numRows: Int) {
        self.numCols = numCols
        self.numRows = numRows
    }

    // Return true if this ocean contains the coordinate point
    func contains(_ point: Coordinate) -> Bool {
        return (point.x >= origin.x &&
                point.y >= origin.y &&
                point.x < numCols &&
                point.y < numRows)
    }

    
    // Return true if this ocean contains all the given coordinate points
    func contains(_ points: Array<Coordinate>) -> Bool {
        return !points.contains(where: { !self.contains($0) })
    }

    /*
     Return all the locations that will fit a certain length of contiguous locations on the ocean
     in either a horizontal or vertical orientation
     */
    func locationsThatFit(length: Int) -> [[Coordinate]] {
        var locations = [[Coordinate]]()

        //horizontal possible fits for each row
        for y in 0..<numRows {
            for start in 0...(numCols - length) {
                var span = [Coordinate]()
                for x in start..<(start + length) {
                    span.append(Coordinate(x: x, y: y))
                }
                locations.append(span)
            }
        }

        //vertical possible fits for each column
        for x in 0..<numCols {
            for start in 0...(numRows - length) {
                var span = [Coordinate]()
                for y in start..<(start + length) {
                    span.append(Coordinate(x: x, y: y))
                }
                locations.append(span)
            }
        }
        return locations
    }
}
