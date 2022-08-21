//
//  PracticeView.swift
//  PirateWar
//
//  Created by Minh Pham on 09/08/2022.
//

import SwiftUI

struct PracticeView: View {
    @EnvironmentObject var navigationHelper: NavigationHelper

    @StateObject var game = Game()
    @State var turn: Int = 1
    @State var winner: Winner = Winner.unknown

    // Timer
    @State var seconds: Int = 0
    @State var timerIsPaused: Bool = true
    @State var timer: Timer? = nil
    @State var timerValue: String = "00:00:00"

    @State var showPopupResult: Bool = false
    @State var result = Result.zero

    var body: some View {
        ZStack {
            VStack {
                ToolbarView(turn: $turn, timerValue: $timerValue)
                    .environmentObject(game)
                Spacer()
                OceanView(showDeployedFleet: false, turn: $turn, winner: $winner)
                    .environmentObject(game)
                Spacer()
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
                        reset()
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
                self.result = Result(turn: turn, seconds: seconds, destroyedShips: game.fleet.shipsDestroyed(), hitShot: game.hitShot())
            }
        }
    }

    func reset() {
        game.reset()
        self.turn = 1
        self.result = .zero
        self.winner = .unknown
        self.showPopupResult = false
        restartTimer()
        startTimer()
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

struct Practice_Previews: PreviewProvider {
    static var previews: some View {
        PracticeView()
            .preferredColorScheme(.dark)
            .previewInterfaceOrientation(.portrait)
    }
}
