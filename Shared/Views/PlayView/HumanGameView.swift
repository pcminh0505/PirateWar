//
//  HumanGameView.swift
//  PirateWar (iOS)
//
//  Created by Minh Pham on 19/08/2022.
//

import SwiftUI

struct HumanGameView: View {
    let deployedFleet: [Ship]
    
    @StateObject var botGame: Game
    @StateObject var humanGame = Game()
    @State var bot = HuntParityAIModel()
    @State var turn = 1

    @State var winner: Winner = Winner.unknown
    @State var point: Float = 0.0
    
    @State var hours: Int = 0
    @State var minutes: Int = 0
    @State var seconds: Int = 0
    @State var timerIsPaused: Bool = true
    
    @State var timer: Timer? = nil
    
    
    init(deployedFleet: [Ship]) {
        self.deployedFleet = deployedFleet
        _botGame = StateObject(wrappedValue: Game(deployedFleet: deployedFleet))
    }
    
    var body: some View {
        VStack {
            AIOceanView()
                .environmentObject(botGame)
                .onChange(of: turn) { _ in
                    if winner != .AI || winner == .unknown {
                        botMove(game: botGame)
                    }
                }
            Spacer()
            VStack {
                ToolbarView()
                    .environmentObject(humanGame)
                HStack {
                    
                    Text("Turn \(turn)")
                    Spacer()
                    Text("\(winner == .human ? "You" : "AI") won!")
                        .opacity(winner == .unknown ? 0.0 : 1.0)
                    Text("Accuracy")
                        .opacity(winner == .unknown ? 0.0 : 1.0)
                }
            }
            
            Spacer()
            OceanView(showDeployedFleet: false, turn: $turn, winner: $winner)
                .environmentObject(humanGame)
            
        }
            .padding()
            .navigationBarHidden(true)
            .background(Color.theme.background)
            .onAppear {
            BackgroundManager.instance.startPlayer(track: "ocean", loop: true)
        }
    }
    
    func botMove(game: Game) -> Void {
        if !game.over {
            let location: Coordinate = bot.nextMove()
            game.zoneTapped(location)
            game.zoneTapped(location)
            if game.over {
                self.winner = .AI
            } else if (game.zoneStates[location.x][location.y] == .sunk ||
                game.zoneStates[location.x][location.y] == .hit) {
                bot.feedback(success: true)
            } else {
                bot.feedback(success: false)
            }
        }
    }
}

struct HumanGameView_Previews: PreviewProvider {
    static var previews: some View {
        HumanGameView(deployedFleet: [])
    }
}
