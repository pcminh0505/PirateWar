//
//  ShipCompartment.swift
//  PirateWar (iOS)
//
//  Created by Minh Pham Cong on 12/08/2022.
//

import Foundation

// ShipCompartment represents the coordinate of single part of a ship
class ShipCompartment {
    var location: Coordinate = .zero
    var flooded: Bool
    
    init(location: Coordinate, flooded: Bool = false) {
        self.location = location
        self.flooded = flooded
    }
}

extension ShipCompartment: CustomStringConvertible {
    var description: String {
        return location.description
    }
}
