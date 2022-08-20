//
//  ShipModel.swift
//  PirateWar (iOS)
//
//  Created by Minh Pham Cong on 12/08/2022.
//

import Foundation

/*
     Ship represents a ship with a name and a set of coordiantes that it occupies via ShipCompartments
     Each compartment can be individually flooded.
     If all compartments are flooded, the ship is sunk.
 */
class Ship {
    var name: String
    var length: Int { return compartments.count }
    var compartments: [ShipCompartment]

    init(_ name: String, coordinates: [Coordinate]) {
        self.name = name
        self.compartments = [ShipCompartment]()
        for coordinate in coordinates.sorted(by: { $0.x < $1.x }) {
            compartments.append(ShipCompartment(location: coordinate))
        }
    }
    
    func isVertical() -> Bool {
        return compartments[0].location.x == compartments[1].location.x
    }

    // Return all the coordinates that the ship occupies
    func coordinates() -> [Coordinate] {
        return Array(compartments.map { $0.location })
    }

    // Return true if the ship occupies the given coordinate
    func occupies(_ location: Coordinate) -> Bool {
        return compartments.contains(where: { $0.location == location })
    }

    // Return true if the ship is sunk (all compartments are flooded)
    func isSunk() -> Bool {
        // Not sunk if at least one of compartments is not flooded)
        return !compartments.contains(where: { !$0.flooded })
    }

    // The ship is hit at the given coordinate.
    func hit(at location: Coordinate) {
        if let compartment = compartments.first(where: { $0.location == location }) {
            compartment.flooded = true
        }
    }
}

extension Ship: CustomStringConvertible {
    var description: String {
        return name + ": " + compartments.description
    }
}

