//
//  ToolbarView.swift
//  PirateWar (iOS)
//
//  Created by Minh Pham on 12/08/2022.
//

import SwiftUI

struct ToolbarView: View {
    @EnvironmentObject var game: Game
    @Binding var winner: Winner
//    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @Binding var turn: Int

    @State var hours: Int = 0
    @State var minutes: Int = 0
    @State var seconds: Int = 0
    @State var timerIsPaused: Bool = true

    @State var timer: Timer? = nil

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

                    (Text(Image(systemName: "clock")) + Text(" Time elapsed: \(String(format: "%02d", minutes)):\(String(format: "%02d", seconds))"))
                        .font(.caption)
                        .onChange(of: winner) { newValue in
                        stopTimer()
                    }

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
            .onAppear {
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

struct ToolbarView_Previews: PreviewProvider {
    static var previews: some View {
        ToolbarView(winner: .constant(.unknown), turn: .constant(1))
            .preferredColorScheme(.dark)
            .environmentObject(Game())
    }
}
