//
//  HumanGameView.swift
//  PirateWar (iOS)
//
//  Created by Minh Pham on 19/08/2022.
//

import SwiftUI

struct HumanGameView: View {
    @EnvironmentObject var navigationHelper: NavigationHelper
    @Binding var isReset: Bool
    let deployedFleet: [Ship]

    // Game initializers
    @StateObject var botGame: Game
    @StateObject var humanGame = Game()
    @State var bot = HuntParityAIModel()
    @State var turn = 1
    @State var botTurn = false
    @State var winner: Winner = Winner.unknown

    // Timer
    @State var seconds: Int = 0
    @State var timerIsPaused: Bool = true
    @State var timer: Timer? = nil
    @State var timerValue: String = "00:00:00"

    // Popup Result
    @State var result = Result.zero
    @State var showPopupResult = false

    @Namespace private var animation

    init(deployedFleet: [Ship], isReset: Binding<Bool>) {
        self.deployedFleet = deployedFleet
        self._isReset = isReset
        _botGame = StateObject(wrappedValue: Game(deployedFleet: deployedFleet))
    }

    var body: some View {
        ZStack {
            VStack(spacing: 10) {
                ToolbarView(turn: $turn, timerValue: $timerValue)
                    .environmentObject(humanGame)
                Spacer()

                if !botTurn {
                    VStack(alignment: .center) {
                        Text("Your turn")
                        OceanView(showDeployedFleet: true, turn: $turn, winner: $winner)
                            .matchedGeometryEffect(id: "SwitchOceanView", in: animation)
                            .environmentObject(humanGame)
                    }
                }
                if botTurn {
                    VStack(alignment: .center) {
                        Text("Bot is playing")
                        AIOceanView()
                            .matchedGeometryEffect(id: "SwitchOceanView", in: animation)
                            .environmentObject(botGame)
                    }
                }
                HStack(spacing: 20) {
                    Button {
                        navigationHelper.selection = nil
                        BackgroundManager.instance.startPlayer(track: "homebackground", loop: true)
                    } label: {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.theme.primaryText, lineWidth: 2)
                            .overlay(
                            Text("Back to Home")
                                .font(.headline)
                        )
                            .frame(height: 55)
                    }
                        .controlSize(.regular)
                        .cornerRadius(20)

                    Button {
                        isReset.toggle()
                        BackgroundManager.instance.startPlayer(track: "deploy", loop: true)
                    } label: {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.theme.primaryText, lineWidth: 2)
                            .overlay(
                            Text("Reset")
                                .font(.headline)
                        )
                            .frame(height: 55)
                    }
                        .controlSize(.regular)
                        .cornerRadius(20)
                }
                    .foregroundColor(Color.theme.primaryText)
            }
                .onChange(of: turn) { _ in
                withAnimation {
                    botTurn.toggle()
                }
                if winner != .AI || winner == .unknown {
                    botMove(game: botGame)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        withAnimation {
                            botTurn.toggle()
                        }
                    }
                }
            }
                .padding()
                .navigationBarHidden(true)
                .background(Color.theme.background)
            PopupResult(isVictory: winner == .human, show: $showPopupResult, result: $result)
                .onChange(of: winner) { value in
                if value != .unknown {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation(.easeIn) {
                            showPopupResult = true
                        }
                    }
                }
            }

        }
            .onAppear {
            BackgroundManager.instance.startPlayer(track: "ocean", loop: true)
            startTimer()
        }
            .onChange(of: winner) { value in
            stopTimer()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.result = Result(turn: turn, seconds: seconds, destroyedShips: humanGame.fleet.shipsDestroyed(), hitShot: humanGame.hitShot())
            }
        }
    }

    func botMove(game: Game) -> Void {
        if !game.over {
            let location: Coordinate = bot.nextMove()
            game.zoneTapped(location)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
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

    func startTimer() {
        timerIsPaused = false
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { tempTimer in
            self.seconds += 1
            self.timerValue = TimeHelper.printSecondsToTimeNumber(self.seconds)
        }
    }

    func stopTimer() {
        timerIsPaused = true
        timer?.invalidate()
        timer = nil
    }

    func restartTimer() {
        seconds = 0
    }
}

struct HumanGameView_Previews: PreviewProvider {
    static var previews: some View {
        HumanGameView(deployedFleet: [], isReset: .constant(false))
            .environmentObject(NavigationHelper())
    }
}
