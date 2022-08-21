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
    @State var showPopupResult = false
    @State var winner: Winner = Winner.unknown


    // Timer
    @State var hours: Int = 0
    @State var minutes: Int = 0
    @State var seconds: Int = 0
    @State var timerIsPaused: Bool = true
    @State var timer: Timer? = nil
    @State var timerValue: String = ""

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
                        OceanView(showDeployedFleet: false, turn: $turn, winner: $winner)
                            .transition(.move(edge: .leading))
                            .matchedGeometryEffect(id: "SwitchOceanView", in: animation)
                            .environmentObject(humanGame)
                    }
                }
                if botTurn {
                    VStack(alignment: .center) {
                        Text("Bot is playing")
                        AIOceanView()
                            .transition(.move(edge: .trailing))
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
            PopupResult(isVictory: winner == .human, show: $showPopupResult)
                .onChange(of: winner) { _ in
                showPopupResult = true
            }

        }
            .onAppear {
            BackgroundManager.instance.startPlayer(track: "ocean", loop: true)
            startTimer()
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
            if self.seconds == 59 {
                self.seconds = 0
                if self.minutes == 59 {
                    self.minutes = 0
                    self.hours = self.hours + 1
                } else {
                    self.minutes = self.minutes + 1
                }
            } else {
                self.seconds = self.seconds + 1
            }
            self.timerValue = "\(String(format: "%02d", hours)):\(String(format: "%02d", minutes)):\(String(format: "%02d", seconds))"
        }
    }

    func stopTimer() {
        timerIsPaused = true
        timer?.invalidate()
        timer = nil
    }

    func restartTimer() {
        hours = 0
        minutes = 0
        seconds = 0
    }
}

struct HumanGameView_Previews: PreviewProvider {
    static var previews: some View {
        HumanGameView(deployedFleet: [], isReset: .constant(false))
            .environmentObject(NavigationHelper())
    }
}
