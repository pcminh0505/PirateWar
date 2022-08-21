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
    @State var hours: Int = 0
    @State var minutes: Int = 0
    @State var seconds: Int = 0
    @State var timerIsPaused: Bool = true
    @State var timer: Timer? = nil
    @State var timerValue: String = ""

    @State var showPopupResult: Bool = false
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

    func reset() {
        game.reset()
        restartTimer()
        startTimer()
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

struct Practice_Previews: PreviewProvider {
    static var previews: some View {
        PracticeView()
            .preferredColorScheme(.dark)
            .previewInterfaceOrientation(.portrait)
    }
}
