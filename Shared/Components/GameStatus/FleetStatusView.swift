//
//  FleetStatusView.swift
//  PirateWar (iOS)
//
//  Created by Minh Pham on 13/08/2022.
//

import SwiftUI

struct FleetStatusView: View {
    @EnvironmentObject var game: Game
    let squareSize: CGFloat

    var body: some View {
        HStack (alignment: .bottom, spacing: 0) {
            ForEach(game.fleet.ships, id: \.name) { ship in
                VStack (spacing: 0) {
                    ForEach((1...ship.length), id: \.self) { _ in
                        ZStack {
                            Rectangle()
                                .strokeBorder(.black, lineWidth: 1)
                                .background(Color.theme.red)
                                .opacity(ship.isSunk() ? 0.5 : 1.0)
                                .frame(width: squareSize, height: squareSize)
                            if (ship.isSunk()) {
                                Image(systemName: "xmark")
                                    .foregroundColor(Color.black)
                            }
                        }
                    }
                }
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
    }
}

struct StatusView_Previews: PreviewProvider {
    static var previews: some View {
        FleetStatusView(squareSize: 30)
            .environmentObject(Game())
    }
}
