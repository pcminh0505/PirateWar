//
//  HuntParityAIModel.swift
//  PirateWar (iOS)
//
//  Created by Minh Pham on 20/08/2022.
// https://github.com/Oliver-Binns/Battleships-AI---Swift-Playground
// https://www.datagenetics.com/blog/december32011/

import Foundation

struct HuntParityAIModel {
    private var attacked: [Coordinate] = []
    private var knownShips: [SeekAndDestroy] = []
    private var lastMove: Move?

    public init() { }

    private func getRandomCell() -> Coordinate {
        let x = Int(arc4random_uniform(10))
        let y = Int(arc4random_uniform(10))
        return Coordinate(x: x, y: y)
    }

    public mutating func nextMove() -> Coordinate {
        for ship in knownShips {
            if(!ship.isDestroyed) {
                // If ship has not been destroyed- return the next suggested move..
                var nextMove = ship.nextMove()
                lastMove = Move(origin: nextMove, ship: ship)
                while(!Ocean(numCols: 10, numRows: 10).contains(nextMove) || attacked.contains(nextMove)) {
                    if(ship.isDestroyed) {
                        return getParityMove()
                    }
                    ship.feedback(success: false)
                    attacked.append(nextMove)
                    nextMove = ship.nextMove()
                    lastMove = Move(origin: nextMove, ship: ship)
                }
                attacked.append(nextMove)
                return nextMove
            }
        }
        //All KNOWN ships have been destroyed- move randomly.
        return getParityMove()
    }

    private mutating func getParityMove() -> Coordinate {
        var origin = getRandomCell()
        while(attacked.contains(origin) || (origin.x % 2 != origin.y % 2)) {
            origin = getRandomCell()
        }
        attacked.append(origin)
        lastMove = Move(origin: origin, ship: nil)
        return origin
    }

    public mutating func feedback(success: Bool) {
        //Our attack was successful, we want to remember this!
        if(success) {
            //If we are already attacking a specific ship..
            if let attackedShip = lastMove!.ship {
                attackedShip.feedback(success: success)
            } else {
                self.knownShips.append(SeekAndDestroy(location: lastMove!.origin))
            }
        }
    }

    class Move {
        let origin: Coordinate
        let ship: SeekAndDestroy?

        init(origin: Coordinate, ship: SeekAndDestroy?) {
            self.origin = origin
            self.ship = ship
        }
    }

    class SeekAndDestroy {
        var distanceAttacked = 0;
        var destroyed = 1 //Seek and Destroy has been created- so the ship must have been hit once..

        var top = false
        var left = false
        var bottom = false

        var knownLocation: Coordinate

        var isDestroyed = false

        init(location: Coordinate) {
            self.knownLocation = location
        }

        func feedback(success: Bool) {
            if(success) {
                destroyed += 1
                distanceAttacked += 1
            } else {
                distanceAttacked = 0

                if(!top) {
                    top = !top
                } else if(!bottom) {
                    bottom = !bottom
                } else if(!left) {
                    left = !left
                } else {
                    isDestroyed = true
                }
            }
        }

        func nextMove() -> Coordinate {
            if(!top) {
                return knownLocation.increment(x: 0, y: -1 - distanceAttacked)
            } else if(!bottom) {
                return knownLocation.increment(x: 0, y: 1 + distanceAttacked)
            } else if(!left) {
                return knownLocation.increment(x: -1 - distanceAttacked, y: 0)
            } else {
                return knownLocation.increment(x: 1 + distanceAttacked, y: 0)
            }
        }
    }
}

