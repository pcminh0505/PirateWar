//
//  HumanGameView.swift
//  PirateWar (iOS)
//
//  Created by Minh Pham on 19/08/2022.
//

import SwiftUI

struct HumanGameView: View {
    @StateObject var game: Game
    @StateObject var botGame =  Game()
    
    var body: some View {
        VStack {
            ToolbarView()
                .environmentObject(game)
            OceanView(isDeployedFleet: true)
                .environmentObject(game)
            OceanView(isDeployedFleet: false)
                .environmentObject(botGame)
            Spacer()
        }
        .padding()
        .navigationBarHidden(true)
        .background(Color.theme.background)
        .onAppear {
        BackgroundManager.instance.startPlayer(track: "ocean", loop: true)
        }
    }
}

struct HumanGameView_Previews: PreviewProvider {
    static var previews: some View {
        HumanGameView(game: Game(), botGame: Game())
    }
}
