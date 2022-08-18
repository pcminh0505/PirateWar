//
//  Location.swift
//  PirateWar (iOS)
//
//  Created by Minh Pham on 18/08/2022.
//

import Foundation

class LocationHelper {
    static func mapFullCoordinate (isVertical: Bool, length: Int, topLocation: Coordinate) -> [Coordinate] {
        var location: [Coordinate] = []
        if isVertical {
            for y in (0..<length) {
                let compartment: Coordinate = Coordinate(x: topLocation.x, y: topLocation.y + y)
                location.append(compartment)
            }
        } else {
            for x in (0..<length) {
                let compartment: Coordinate = Coordinate(x: topLocation.x - x, y: topLocation.y)
                location.append(compartment)
            }
        }
        return location
    }
    
    static func isOverlapped (shipCoordinate: [Coordinate], fleet: [[Coordinate]]) -> Bool {
        for existedShip in fleet {
            for compartment in shipCoordinate {
                if existedShip.contains(compartment) {
                    return true
                }
            }
        }
        return false
    }
}
