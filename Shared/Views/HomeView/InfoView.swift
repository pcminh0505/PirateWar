//
//  InfoView.swift
//  PirateWar
//
//  Created by Minh Pham on 09/08/2022.
//

import SwiftUI

struct InfoView: View {
    @Environment(\.presentationMode) var presentationMode

    let classicBoardGame = URL(string: "https://www.ultraboardgames.com/battleship/game-rules.php")!
    let tipsToPlay = URL(string: "https://www.ultraboardgames.com/battleship/tips.php")!
    let AIModeling = URL(string: "https://www.datagenetics.com/blog/december32011/")!

    let pirateThemeURL = URL(string: "https://www.behance.net/gallery/96254475/Pirate-Game-Elements")!
    let lottieURL = URL(string: "https://lottiefiles.com/54038-pirates")!
    let pixabayURL = URL(string: "https://pixabay.com/")!
    let rankingURL = URL(string: "https://www.artstation.com/artwork/Aq4VPz")!
    
    let personalURL = URL(string: "https://pcminh0505.vercel.app/")!

    init() {
        // Hide scroll bar
        UITableView.appearance().showsVerticalScrollIndicator = false
    }
    var body: some View {
        NavigationView {
            List {
                Section {
                    Text("PirateWar is a priate-theme for classic Battleship boardgame, built with SwiftUI")
                        .foregroundColor(Color.theme.primaryText)
                        .fontWeight(.medium)
                    Link("🎲 Classic Boardgame", destination: classicBoardGame)
                        .font(.headline)
                    Link("📖 Playing Tips", destination: tipsToPlay)
                        .font(.headline)
                    Link("🤖 AI Modeling", destination: AIModeling)
                        .font(.headline)
                }
                header: {
                    Text("Description")
                }

                Section {
                    HStack {
                        Text("Board Size")
                            .bold()
                        Spacer()
                        Text("10 x 10")
                    }
                    VStack {
                        HStack {
                            Text("Number of Ships")
                                .bold()
                            Spacer()
                            Text("5")
                        }
                    }
                    VStack (spacing: 10) {
                        HStack {
                            Text("Carrier Size")
                                .bold()
                            Spacer()
                            Text("5x1")
                        }
                        HStack {
                            Text("Battleship Size")
                                .bold()
                            Spacer()
                            Text("4x1")
                        }
                        HStack {
                            Text("Cruiser Size")
                                .bold()
                            Spacer()
                            Text("3x1")
                        }
                        HStack {
                            Text("Submarine Size")
                                .bold()
                            Spacer()
                            Text("3x1")
                        }
                        HStack {
                            Text("Destroyer Size")
                                .bold()
                            Spacer()
                            Text("2x1")
                        }
                    }
                    VStack (spacing: 10) {
                        HStack {
                            Text("⚪️ Hit")
                                .bold()
                            Spacer()
                            Text("Hit a part of a ship")
                        }
                        HStack {
                            Text("🔴 Miss")
                                .bold()
                            Spacer()
                            Text("Not hit any part of a ship")
                        }
                        HStack {
                            Text("⚫️ Sunk")
                                .bold()
                            Spacer()
                            Text("Sunk a ship")
                        }
                    }
                } header: {
                    Text("Classic Game")
                }

                Section {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Player vs AI")
                            .font(.headline)
                            .foregroundColor(Color.theme.red.opacity(0.8))

                        Text("Including fleet deployment. Turn based gameplay between human vs random AI deployment and strategy")
                            .font(.body)
                    }
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Practice")
                            .font(.headline)
                            .foregroundColor(Color.theme.red.opacity(0.8))

                        Text("Practice guessing strategy on random fleet deployment")
                            .font(.body)
                    }

                } header: {
                    Text("Game Mode")
                }

                Section {
                    Link("🏴‍☠️ Game Elements: Behance ", destination: pirateThemeURL)
                        .font(.headline)
                    Link("🌟 Animated GIF: Lottie", destination: lottieURL)
                        .font(.headline)
                    Link("🔊 Sound Resources: Pixabay", destination: pixabayURL)
                        .font(.headline)
                    Link("🔊 Leaderboard Resources: ArtStation", destination: rankingURL)
                        .font(.headline)
                } header: {
                    Text("Resources")
                }

                Section {
                    HStack {
                        Text("App Name")
                            .bold()
                        Spacer()
                        Text("Pirate War")
                    }
                    HStack {
                        Text("RMIT University")
                            .bold()
                        Spacer()
                        Text("SGS Campus")
                    }
                    HStack {
                        Text("Course ID")
                            .bold()
                        Spacer()
                        Text("COSC2659")
                    }
                    HStack {
                        Text("Course")
                            .bold()
                        Spacer()
                        Text("iOS Development")
                    }
                    HStack {
                        Text("Published Year")
                            .bold()
                        Spacer()
                        Text("2022")
                    }
                    HStack {
                        Text("Author")
                            .bold()
                        Spacer()
                        Link("Minh Pham", destination: personalURL)
                    }

                } header: {
                    Text("Association")
                }

            }
                .onAppear {
                // Placed here for sample purposes, normally set globally
                UITableView.appearance().backgroundColor = .clear
            }
                .listStyle(GroupedListStyle())
                .background(Color.theme.background)
                .navigationTitle("Application Info")
                .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark.circle")
                            .foregroundColor(Color.theme.primaryText)
                            .font(.headline)
                    }
                }
            }
        }
    }
}

struct HowToPlayView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
            .preferredColorScheme(.dark)
    }
}
