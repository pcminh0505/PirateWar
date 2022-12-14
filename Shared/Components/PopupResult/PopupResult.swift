//
//  PopupResult.swift
//  PirateWar (iOS)
//
//  Created by Minh Pham on 21/08/2022.
//

import SwiftUI

struct PopupResult: View {
    @EnvironmentObject var users: Users

    let isVictory: Bool
    @Binding var show: Bool
    @Binding var result: Result

    let columns: [GridItem] = [
        GridItem(.flexible(), alignment: .trailing),
        GridItem(.flexible(), alignment: .center),
    ]

    var body: some View {
        let user = users.getCurrentUser()
        GeometryReader { geo in
            if show {
                ZStack() {
                    Color.theme.background.opacity(show ? 0.4 : 0).edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                        show.toggle()
                    }

                    VStack (spacing: 15) {
                        Image(isVictory ? "Victory" : "Defeat")
                            .resizable()
                            .scaledToFit()
                            .frame(height: geo.size.height * 0.3)


                        LazyVGrid(columns: columns, spacing: 20) {
                            Text("Number of Turns")
                                .font(.headline)
                            Text("\(result.turn)")
                            Text("Time ellapsed")
                                .font(.headline)
                            Text(TimeHelper.printSecondsToTimeNumber(result.seconds))
                            Text("Destroyed Ships")
                                .font(.headline)
                            Text("\(result.destroyedShips)")
                            Text("Accuracy")
                                .font(.headline)
                            Text("\(String(format: "%.2f", result.accuracy * 100))%")
                            Text("Total Score")
                                .font(.title2)
                                .foregroundColor(isVictory ? Color.theme.blue : Color.theme.red)
                                .bold()
                            Text("\(result.totalScore)")
                                .font(.title2)
                                .foregroundColor(isVictory ? Color.theme.blue : Color.theme.red)
                                .bold()
                        }


                        Text("???? New highscore achieved! ????")
                            .font(.caption)
                            .bold()
                            .opacity(result.totalScore > user.1 ? 1.0 : 0.0)
                    }
                        .padding()
                        .foregroundColor(Color.theme.primaryText)
                        .background(Color.theme.woodBackground)
                        .cornerRadius(25)
                        .frame(maxWidth: geo.size.width * 0.85, maxHeight: geo.size.height * 0.6)
                }
                    .transition(AnyTransition.opacity.animation(.easeInOut))
                    .onDisappear {
                    users.updateHighscore(newScore: result.totalScore)
                }
            }
        }
    }
}

struct PopupResult_Previews: PreviewProvider {
    static var previews: some View {
        PopupResult(isVictory: true, show: .constant(true), result: .constant(Result(turn: 20, seconds: 120, destroyedShips: 5, hitShot: 17)))
            .preferredColorScheme(.light)
            .environmentObject(Users())
    }
}
