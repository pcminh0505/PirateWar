//
//  FleetView.swift
//  PirateWar (iOS)
//
//  Created by Minh Pham on 13/08/2022.
//

import SwiftUI

struct FleetView: View {
    @EnvironmentObject var game: Game
    let squareSize: CGFloat

    var body: some View {
        VStack (spacing: 15) {
            ForEach(game.fleet.ships, id: \.name) { ship in
                VStack (alignment: .leading) {
                    Text(ship.name)
                        .padding(.leading, squareSize / 2)
                        .font(.headline)
                    HStack {
                        Image(ship.name)
                            .resizable()
                            .frame(width: squareSize, height: squareSize * CGFloat(ship.length))
                            .rotationEffect(Angle(degrees: 90))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, squareSize / 2 * CGFloat(ship.length))

                        HStack (spacing: 0) {
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
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                        .padding(.vertical, -squareSize / 2.5 * CGFloat(ship.length))
                }
//                .padding(.top, -squareSize / 4 * CGFloat(ship.length))
            }
        }
            .scaledToFill()
    }
}

struct FleetView_Previews: PreviewProvider {
    static var previews: some View {
        FleetView(squareSize: 30)
            .environmentObject(Game())
    }
}
