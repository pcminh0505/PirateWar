//
//  PracticeView.swift
//  PirateWar
//
//  Created by Minh Pham on 09/08/2022.
//

import SwiftUI

struct PracticeView: View {
    @StateObject var game = Game()
    @State var turn: Int = 1
    @State var winner: Winner = Winner.unknown

    @State var showPopupResult: Bool = false
    var body: some View {
        ZStack {
            VStack {
                ToolbarView(winner: $winner, turn: $turn)
                    .environmentObject(game)
                Spacer()
                OceanView(showDeployedFleet: true, turn: $turn, winner: $winner)
                    .environmentObject(game)
                Spacer()
                HStack(spacing: 20) {
                    Button {
                        print("Hello")
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
                        print("Hello")
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
        }
    }
}

struct Practice_Previews: PreviewProvider {
    static var previews: some View {
        PracticeView()
            .preferredColorScheme(.dark)
            .previewInterfaceOrientation(.portrait)
    }
}
