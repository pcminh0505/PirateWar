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
    @State var bot: AIModel = AIModelManager.getBotLevel(bot: UserDefaults.standard.string(forKey: "difficulty") ?? "Easy")
    @State var turn = 1
    @State var botTurn = false
    @State var winner: Winner = Winner.unknown

    @State var showEnemyFleet: Bool = false
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
//        let _ = print(bot) // Debug
        ZStack {
            VStack(spacing: 10) {
                GameStatusView(turn: $turn, timerValue: $timerValue)
                    .environmentObject(humanGame)

                VStack (alignment: .center, spacing: 10) {
                    Text(botTurn ? "🤖 Bot is playing..." : "📌 Your turn")
                        .font(.title3)
                        .bold()
                        .foregroundColor(Color.theme.primaryText)

                    HStack {
                        Button {
                            withAnimation {
                                showEnemyFleet.toggle()
                            }
                        } label: {
                            HStack (spacing: 10) {
                                Image(systemName: "chevron.up.square")
                                    .rotationEffect(.degrees(self.showEnemyFleet ? 0 : 180))
                                    .animation(.easeInOut, value: showEnemyFleet)
                                Text(showEnemyFleet ? "Hide Enemy Fleet" : "Show Enemy Fleet")

                            }
                                .foregroundColor(Color.theme.primaryText)
                        }
                    }
                    if showEnemyFleet {
                        FleetStatusView(squareSize: UIScreen.main.bounds.width * 0.05)
                            .environmentObject(humanGame)
                    }

                }
                if !botTurn {
                    OceanView(showDeployedFleet: false, turn: $turn, winner: $winner)
                        .matchedGeometryEffect(id: "SwitchOceanView", in: animation)
                        .environmentObject(humanGame)
                }
                if botTurn {
                    AIOceanView()
                        .matchedGeometryEffect(id: "SwitchOceanView", in: animation)
                        .environmentObject(botGame)
                }
                Spacer()
                HStack(spacing: 10) {
                    Button {
                        navigationHelper.selection = nil
                        BackgroundManager.instance.startPlayer(track: "homebackground", loop: true)
                    } label: {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.theme.primaryText, lineWidth: 2)
                            .overlay(
                            (Text(Image(systemName: "list.dash")) + Text(" Home"))
                                .font(.body)
                                .bold()
                                .padding()
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
                            (Text(Image(systemName: "arrow.counterclockwise")) + Text(" Reset"))
                                .font(.body)
                                .bold()
                                .padding()
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
                            SoundEffectManager.instance.startPlayer(track: winner == .human ? "victory" : "defeat", loop: false)
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
            humanGame.over = true
            botGame.over = true
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
//                self.winner = .AI // Debug
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
