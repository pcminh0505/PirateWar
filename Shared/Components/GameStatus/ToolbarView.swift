//
//  ToolbarView.swift
//  PirateWar (iOS)
//
//  Created by Minh Pham on 12/08/2022.
//

import SwiftUI

struct ToolbarView: View {
    @EnvironmentObject var game: Game

    @Binding var turn: Int
    @Binding var timerValue: String

    @State var isAnimating: Bool = false

    var body: some View {
        VStack {
            ZStack {
                InvertCornerRectangle()
                    .fill(Color.theme.woodBackground)

                VStack(alignment: .center, spacing: 10) {
                    Text("Turn: \(turn)")
                        .font(.title2)
                        .bold()

                    (Text(Image(systemName: "clock")) + Text(" Time elapsed: \(timerValue)"))
                        .font(.caption)

                    Text(game.message != "" ? game.message : "Game started!")
                        .frame(maxWidth: .infinity)
                        .transition(.asymmetric(insertion: .scale, removal: .opacity))
                        .animation(.spring(), value: game.message)
                }
                    .foregroundColor(Color.theme.primaryText)
                    .padding()

            }
                .fixedSize(horizontal: false, vertical: true)
            FleetStatusView(squareSize: 25)
        }
    }
}

struct ToolbarView_Previews: PreviewProvider {
    static var previews: some View {
        ToolbarView(turn: .constant(1), timerValue: .constant("00:00"))
            .preferredColorScheme(.dark)
            .environmentObject(Game())
    }
}
