//
//  TestView.swift
//  PirateWar (iOS)
//
//  Created by Minh Pham Cong on 16/08/2022.
//

import SwiftUI

struct DeployView: View {
    let range = (0..<(Game.numCols * Game.numRows))
    let columns = [GridItem](repeating: GridItem(.flexible(), spacing: 0), count: Game.numCols)

    // Top of the ship location
    @State var shipStatus = [(isVertical: Bool, topLocation: Coordinate)](repeating: (isVertical: true, topLocation: .zero), count: 5)
    @State var shipBaseCoordinate = [Coordinate](repeating: .zero, count: 5)
    @State var stateChange = [Bool](repeating: false, count: 5)
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

                    if (index == 4) {
//                        let _ = print(stateChange[index])
//                        let _ = print(shipStatus[index].isVertical)
//                        let _ = print(stateChange[index] ?
//                        shipStatus[index].isVertical ? "Use Rotate" : "Use offset"
//                        : shipStatus[index].isVertical ? "Use offset" : "Use Rotate")
//                        let _ = print(movedX, movedY)
                        let _ = print("Current location: ", shipStatus[index].topLocation.description)
                        let _ = print("---------")
                    }


                    DraggableImage(name: ship.name, length: ship.length, index: index, squareSize: squareSize, initCoordinate: shipBaseCoordinate[index], shipStatus: $shipStatus[index], stateChange: $stateChange[index])
                        .rotationEffect(shipStatus[index].isVertical ? Angle(degrees: 0) : Angle(degrees: 90))
                        .position(x: geo.frame(in: .local).minX + initOffsetX, y: geo.frame(in: .local).minY + initOffsetY)
                        .overlay(
                        Color.clear
                            .onAppear {
                            self.shipStatus[index].topLocation = Coordinate(x: index, y: 0)
                            self.shipBaseCoordinate[index] = Coordinate(x: index, y: 0)
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
                            if Game().ocean.contains(currentCoordinate) {
                                self.shipStatus[index].isVertical.toggle()
                                self.stateChange[index] = true
                                self.shipStatus[index].topLocation = currentCoordinate
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

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        DeployView()
    }
}
