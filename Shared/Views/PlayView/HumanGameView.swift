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
    @State var botTurn = false
    @State var showPopupResult = false

    @State var winner: Winner = Winner.unknown
    @State var point: Float = 0.0

    @State var timer: Timer? = nil

    @Namespace private var animation

    init(deployedFleet: [Ship]) {
        self.deployedFleet = deployedFleet
        _botGame = StateObject(wrappedValue: Game(deployedFleet: deployedFleet))
    }

    var body: some View {
        ZStack {
            VStack {
                ToolbarView(winner: $winner, turn: $turn)
                    .environmentObject(humanGame)
                Spacer()

                if !botTurn {
                    VStack(alignment: .center) {
                        Text("Your turn")
                        OceanView(showDeployedFleet: false, turn: $turn, winner: $winner)
                            .transition(.move(edge: .leading))
                            .matchedGeometryEffect(id: "SwitchView", in: animation)
                            .environmentObject(humanGame)
                    }
                }
                if botTurn {
                    VStack(alignment: .center) {
                        Text("Bot is playing")
                        AIOceanView()
                            .transition(.move(edge: .trailing))
                            .matchedGeometryEffect(id: "SwitchView", in: animation)
                            .environmentObject(botGame)
                    }
                }
            }
                .onChange(of: turn) { _ in
                withAnimation {
                    botTurn.toggle()
                }
                if winner != .AI || winner == .unknown {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        botMove(game: botGame)
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        withAnimation {
                            botTurn.toggle()
                        }
                    }
                }
            }
                .padding()
                .navigationBarHidden(true)
                .background(Color.theme.background)
            PopupResult(isVictory: winner == .human, show: $showPopupResult)
                .onChange(of: winner) { _ in
                showPopupResult = true
            }

        }
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
