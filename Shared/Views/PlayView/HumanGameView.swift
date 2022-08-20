//
//  HumanGameView.swift
//  PirateWar (iOS)
//
//  Created by Minh Pham on 19/08/2022.
//

import SwiftUI

struct HumanGameView: View {
    @StateObject var game: Game
    @StateObject var AIGame = Game()

    var body: some View {
        VStack {
            AIOceanView()
                .environmentObject(game)
            OceanView(showDeployedFleet: false)
                .environmentObject(AIGame)
            Spacer()
        }
            .padding()
            .navigationBarHidden(true)
            .background(Color.theme.background)
            .onAppear {
            BackgroundManager.instance.startPlayer(track: "ocean", loop: true)
        }
    }
    
//    func botMove(game: Game, bot: inout AIModel) {
//        if !game.over {
//            let location: Coordinate = bot.nextMove()
//            game.zoneTapped(location)
//            game.zoneTapped(location)
//            if (game.zoneStates[location.x][location.y] == .sunk ||
//                game.zoneStates[location.x][location.y] == .hit) {
//                bot.feedback(success: true)
//            } else {
//                bot.feedback(success: false)
//            }
//        }
//    }
}

struct HumanGameView_Previews: PreviewProvider {
    static var previews: some View {
        HumanGameView(game: Game(), AIGame: Game())
    }
}
