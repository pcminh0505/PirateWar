//
//  TestView.swift
//  PirateWar (iOS)
//
//  Created by Minh Pham Cong on 16/08/2022.
//

import SwiftUI

struct TestView: View {
    let range = (0..<(Game.numCols * Game.numRows))
    let columns = [GridItem](repeating: GridItem(.flexible(), spacing: 0), count: Game.numCols)

    var body: some View {
        GeometryReader { geo in
        
            ZStack {
                LazyVGrid(columns: columns, spacing: 0) {
                        ForEach(range, id: \.self) { index in
        //                    let y = index / Game.numRows
        //                    let x = index - (y * Game.numCols)
        //                    let location = Coordinate(x: x, y: y)
                            Rectangle()
                                .strokeBorder(.black, lineWidth: 1)
                                .background(Color.theme.ocean)
                                .aspectRatio(1.0, contentMode: .fit)
                        }
                }
//                HStack (alignment: .bottom, spacing: 0) {
                ForEach(Array(Fleet.shipsInFleet.enumerated()), id: \.offset) { index, ship in
                        Image(ship.name)
                            .resizable()
                            .frame(width: geo.size.width * 0.1 , height: geo.size.width * 0.1 * CGFloat(ship.length))
                            .clipped()
                            .position(x: geo.frame(in: .local).minX, y: geo.frame(in: .local).minY)
                            .offset(x: CGFloat(index) * geo.size.width * 0.1 + geo.size.width * 0.05,
                                    y: ship.length % 2 == 0 ? geo.size.width * 0.1 * CGFloat(ship.length/2) : geo.size.width * 0.1 * CGFloat(ship.length/2) + geo.size.width * 0.05)
                    }
//                }
            }
            .frame(maxWidth: geo.size.width)
            .aspectRatio(1.0, contentMode: .fit)
        }
        .aspectRatio(1.0, contentMode: .fit)
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
