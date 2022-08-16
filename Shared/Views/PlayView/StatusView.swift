//
//  FleetView.swift
//  PirateWar (iOS)
//
//  Created by Minh Pham on 13/08/2022.
//

import SwiftUI

struct StatusView: View {
    @EnvironmentObject var game: Game
    let squareSize: CGFloat

    var body: some View {
        VStack {
            Text("Enemy's Fleet")
                .foregroundColor(Color.theme.primaryText)
                .font(.title3)
                .bold()
            
            HStack (alignment: .bottom) {
                ForEach(game.fleet.ships, id: \.name) { ship in
                    ZStack {
                        VStack (spacing: 0) {
                            ForEach((1...ship.length), id: \.self) { _ in
                                ZStack {
                                    Rectangle()
                                        .strokeBorder(.black, lineWidth: 1)
                                        .background(Color.theme.ocean)
                                        .frame(width: squareSize, height: squareSize)
                                    if (ship.isSunk()) {
                                        Circle()
                                            .fill(Color.black)
                                            .frame(width: squareSize / 2, height: squareSize / 2)

                                    }
                                }
                            }
                        }
                            .frame(maxWidth: .infinity, alignment: .center)
                        Image(ship.name)
                            .resizable()
                            .frame(width: squareSize, height: squareSize * CGFloat(ship.length))
                            .clipped()
                    }
                }
            }
        }
//            .scaledToFill()
    }
}

struct StatusView_Previews: PreviewProvider {
    static var previews: some View {
        StatusView(squareSize: 30)
            .environmentObject(Game())
    }
}
