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

                    let movedX: CGFloat = CGFloat(shipStatus[index].topLocation.x - shipBaseCoordinate[index].x) * squareSize
                    let movedY: CGFloat = CGFloat(shipStatus[index].topLocation.y - shipBaseCoordinate[index].y) * squareSize

                    let _ = print(movedX, movedY)

                    DraggableImage(name: ship.name, length: ship.length, index: index, squareSize: squareSize, initCoordinate: shipBaseCoordinate[index], shipStatus: $shipStatus[index])
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
                        .onTapGesture {
                        var currentCoordinate = shipStatus[index].topLocation
                        if shipStatus[index].isVertical {
                            currentCoordinate.x += Int(ship.length / 2)
                            currentCoordinate.y += Int(ship.length / 2)
                        } else {
                            currentCoordinate.x -= Int(ship.length / 2)
                            currentCoordinate.y -= Int(ship.length / 2)
                        }
                        let _ = print(currentCoordinate.description)
                        if Game().ocean.contains(currentCoordinate) {
                            self.shipStatus[index].isVertical.toggle()
                            self.shipStatus[index].topLocation = currentCoordinate
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
