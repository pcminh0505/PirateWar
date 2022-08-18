//
//  Game.swift
//  PirateWar (iOS)
//
//  Created by Minh Pham on 12/08/2022.
//

import Foundation
import Combine

/*
 The classic Battleship game
 */
final class HumanGame: ObservableObject {
    static let numCols = 10
    static let numRows = 10
    var ocean: Ocean
    var fleet: Fleet

    @Published var zoneStates = [[OceanZoneState]]()
    @Published var selectedZone: Coordinate = Coordinate.unset
    @Published var message = ""
    var over: Bool { return fleet.isDestroyed() }

    init(deployedFleet: [Ship]) {
        self.ocean = Ocean(numCols: Game.numCols, numRows: Game.numRows)
        self.fleet = Fleet()
        self.zoneStates = defaultZoneStates()
        self.message = ""
        self.selectedZone = Coordinate.unset
        self.fleet.dragDeploy(on: self.ocean, deployedShips: deployedFleet)
//        reset()
    }

    /*
     start a new game
     */
//    func reset() {
//        self.zoneStates = defaultZoneStates()
//        self.message = ""
//        self.selectedZone = Coordinate.unset
//        self.fleet.randomDeploy(on: self.ocean)
//    }

    /*
     handle when an OceanZoneView is tapped
     */
    func zoneTapped(_ location: Coordinate) {
        //if we already tapped this location or the game is over, just ignore it
        if ((zoneStates[location.x][location.y] == .sunk) ||
                (zoneStates[location.x][location.y] == .miss) ||
                (zoneStates[location.x][location.y] == .hit) ||
                over) {
            return
        }

        if (selectedZone == Coordinate.unset) {
            // Assign new selectedZone
            selectedZone = location
            zoneStates[location.x][location.y] = .selected
        } else if (selectedZone == location) { // Already selected
            //see if we hit a ship
            if let hitShip = fleet.ship(at: location) {
                hitShip.hit(at: location)
                zoneStates[location.x][location.y] = .hit

                if (hitShip.isSunk()) {
                    message = "🔥 \(hitShip.name) sunk!"
                    hitShip.coordinates().forEach { shipCompartment in
                        zoneStates[shipCompartment.x][shipCompartment.y] = .sunk
                    }
                } else {
                    message = "Hit"
                }
            } else {
                zoneStates[location.x][location.y] = .miss
                message = "Miss"
            }
            selectedZone = Coordinate.unset
        } else {
            // Clear current selectedZone on board
            zoneStates[selectedZone.x][selectedZone.y] = .clear
            // Assign new selectedZone
            selectedZone = location
            zoneStates[location.x][location.y] = .selected
        }

        //are we done?
        if (over) {
            message += " YOU WIN!"
        }
    }

    /*
     create a two dimensional array of OceanZoneStates all set to .clear
     */
    private func defaultZoneStates() -> [[OceanZoneState]] {
        var states = [[OceanZoneState]]()
        for x in 0..<Game.numCols {
            states.append([])
            for _ in 0..<Game.numRows {
                states[x].append(.clear)
            }
        }
        return states
    }

}
