//
//  TestView.swift
//  PirateWar (iOS)
//
//  Created by Minh Pham Cong on 16/08/2022.
//

import SwiftUI

struct DeployOceanView: View {
    let range = (0..<(Game.numCols * Game.numRows))
    let columns = [GridItem](repeating: GridItem(.flexible(), spacing: 0), count: Game.numCols)
    var shipBaseCoordinate: [Coordinate]

    @State var stateChange = [Bool](repeating: false, count: 5)
    @Binding var fleet: [[Coordinate]]
    // Top of the ship location
    @Binding var shipStatus: [(isVertical: Bool, topLocation: Coordinate)]

    var body: some View {
        GeometryReader { geo in
            ZStack {
                LazyVGrid(columns: columns, spacing: 0) {
                    ForEach(range, id: \.self) { index in
                        Rectangle()
                            .strokeBorder(.black, lineWidth: 1)
                            .background(Color.theme.ocean)
                            .aspectRatio(1.0, contentMode: .fit)
                    }
                }

                ForEach(Array(Fleet.shipsInFleet.enumerated()), id: \.offset) { index, ship in
                    let squareSize: CGFloat = geo.size.width * 0.1
                    let initOffsetX = squareSize / 2 + CGFloat(index) * squareSize
                    let initOffsetY = ship.length % 2 == 0 ? squareSize * CGFloat(ship.length / 2) : squareSize * CGFloat(ship.length / 2) + squareSize / 2

                    let movedX = shipStatus[index].isVertical ? shipStatus[index].topLocation.x - shipBaseCoordinate[index].x: shipStatus[index].topLocation.x - ship.length / 2 - shipBaseCoordinate[index].x
                    let movedY = shipStatus[index].isVertical ? shipStatus[index].topLocation.y - shipBaseCoordinate[index].y: shipStatus[index].topLocation.y - ship.length / 2 - shipBaseCoordinate[index].y

                    let offsetRotatedX: CGFloat = shipStatus[index].isVertical ? CGFloat(movedX - movedY) * squareSize : 0
                    let offsetRotatedY: CGFloat = shipStatus[index].isVertical ? CGFloat(movedX + movedY) * squareSize : 0

                    let offsetX: CGFloat = !shipStatus[index].isVertical ? CGFloat(movedX + movedY) * squareSize : 0
                    let offsetY: CGFloat = !shipStatus[index].isVertical ? CGFloat(movedY - movedX) * squareSize : 0

                    DraggableImage(name: ship.name, length: ship.length, index: index, squareSize: squareSize, initCoordinate: shipBaseCoordinate[index], shipStatus: $shipStatus[index], stateChange: $stateChange[index], fleetLocation: $fleet)
                        .rotationEffect(shipStatus[index].isVertical ? Angle(degrees: 0) : Angle(degrees: 90))
                        .position(x: geo.frame(in: .local).minX + initOffsetX, y: geo.frame(in: .local).minY + initOffsetY)
                        .overlay(
                        Color.clear
                            .onAppear {
                            shipStatus[index].topLocation = Coordinate(x: index, y: 0)
                            fleet[index] = LocationHelper.mapFullCoordinate(isVertical: shipStatus[index].isVertical, length: ship.length, topLocation: shipStatus[index].topLocation)
                        }
                    )
                        .offset(x: !shipStatus[index].isVertical && ship.length % 2 == 0 ? squareSize / 2 : 0, y: !shipStatus[index].isVertical && ship.length % 2 == 0 ? squareSize / 2 : 0)

                        .offset(stateChange[index] ?
                    shipStatus[index].isVertical ? CGSize(width: offsetRotatedX, height: offsetRotatedY) : CGSize(width: offsetX, height: offsetY)
                    : shipStatus[index].isVertical ? CGSize(width: offsetX, height: offsetY) : CGSize(width: offsetRotatedX, height: offsetRotatedY))

                        .onTapGesture {
                        if !self.stateChange[index] {
                            var currentCoordinate = shipStatus[index].topLocation
                            if shipStatus[index].isVertical {
                                currentCoordinate.x += ship.length / 2
                                currentCoordinate.y += ship.length / 2
                            } else {
                                currentCoordinate.x -= ship.length / 2
                                currentCoordinate.y -= ship.length / 2
                            }

                            let ocean = Ocean(numCols: 10, numRows: 10)

                            var otherShips = fleet
                            otherShips.remove(at: index)

                            let newShipLocation = LocationHelper.mapFullCoordinate(isVertical: !shipStatus[index].isVertical, length: ship.length, topLocation: currentCoordinate)

                            if (ocean.contains(currentCoordinate) &&
                                    ocean.contains(fleet[index]) &&
                                    !LocationHelper.isOverlapped (shipCoordinate: newShipLocation, fleet: otherShips)) {
                                self.stateChange[index] = true
                                shipStatus[index].isVertical.toggle()
                                shipStatus[index].topLocation = currentCoordinate
                                fleet[index] = LocationHelper.mapFullCoordinate(isVertical: shipStatus[index].isVertical, length: ship.length, topLocation: currentCoordinate)
                            }
                        }
                    }
                }
            }
                .frame(maxWidth: geo.size.width)
                .aspectRatio(1.0, contentMode: .fit)
        }
            .aspectRatio(1.0, contentMode: .fit)
    }

}

struct DeployOceanView_Previews: PreviewProvider {
    static var previews: some View {
        DeployOceanView(shipBaseCoordinate: [Coordinate(x: 0, y: 0),
                                             Coordinate(x: 1, y: 0),
                                             Coordinate(x: 2, y: 0),
                                             Coordinate(x: 3, y: 0),
                                             Coordinate(x: 4, y: 0)],
                        fleet: .constant([[.zero], [.zero], [.zero], [.zero], [.zero]]),
                        shipStatus: .constant([(isVertical: true, topLocation: Coordinate(x: 0, y: 0))]))
    }
}
