//
//  AIOceanView.swift
//  PirateWar (iOS)
//
//  Created by Minh Pham on 12/08/2022.
//

import SwiftUI

struct AIOceanView: View {
    @EnvironmentObject var game: Game
    let range = (0..<(Game.numCols * Game.numRows))
    let columns = [GridItem](repeating: GridItem(.flexible(), spacing: 0), count: Game.numCols)

    var body: some View {
        GeometryReader { geo in
            ZStack {
                LazyVGrid(columns: columns, spacing: 0) {
                    ForEach(range, id: \.self) { index in
                        let y = index / Game.numRows
                        let x = index - (y * Game.numCols)
                        OceanZoneView(state: $game.zoneStates[x][y])
                    }
                }
                ForEach(game.fleet.ships, id: \.name) { ship in
                    let squareSize: CGFloat = geo.size.width * 0.1

                    let baseOffsetX = squareSize / 2

                    let offsetX = ship.isVertical() ? baseOffsetX + CGFloat(ship.compartments[0].location.x) * squareSize: baseOffsetX + CGFloat(ship.compartments[0].location.y) * squareSize

                    let baseOffsetY = ship.length % 2 == 0 ? squareSize * CGFloat(ship.length / 2) : squareSize * CGFloat(ship.length / 2) + squareSize / 2

                    let offsetY = ship.isVertical() ? baseOffsetY + CGFloat(ship.compartments[0].location.y) * squareSize: -(baseOffsetY + CGFloat(ship.compartments[0].location.x) * squareSize)

                    Image(ship.name)
                        .resizable()
                        .frame(width: squareSize, height: squareSize * CGFloat(ship.length))
                        .clipped()
                        .position(x: geo.frame(in: .local).minX, y: ship.isVertical() ? geo.frame(in: .local).minY : geo.frame(in: .local).maxY)
                        .offset(x: offsetX,
                                y: offsetY)
                        .rotationEffect(Angle(degrees: ship.isVertical() ? 0 : 90))
                        .allowsHitTesting(false)
                        .opacity(0.3)
                }
            }
                .frame(maxWidth: geo.size.width)
                .aspectRatio(1.0, contentMode: .fit)
        }
            .aspectRatio(1.0, contentMode: .fit)
    }
}

struct AIOceanView_Previews: PreviewProvider {
    static var previews: some View {
        AIOceanView()
            .environmentObject(Game())
    }
}
