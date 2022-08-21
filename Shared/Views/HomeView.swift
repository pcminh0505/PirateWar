//
//  HomeView.swift
//  PirateWar
//
//  Created by Minh Pham on 09/08/2022.
//

import SwiftUI

struct HomeView: View {
    private var menuOptions: [String: String] = [
        "play": "🕹 Play",
        "instruction": "📖 How to Play",
        "leaderboard": "🏆 Leaderboard",
        "settings": "⚙️ Settings",
    ]
    private var playOptions: [String: String] = [
        "bot": "🤖 Single Player (vs AI)",
        "practice": "🎯 Practice",
        "back": "⬅ Back",
    ]

    @State private var menuSelection: String? = nil
    @State private var playSelection: String? = nil

    @State private var isSelectingPlayMode: Bool = false

    var body: some View {
        NavigationView {
            ZStack {
                LottieView(name: "pirates", loopMode: .loop)
                    .padding(.top, -350)

                VStack {
                    if !isSelectingPlayMode {
                        menuList
    //                        .transition(.move(edge: .leading))
                    }
                    if isSelectingPlayMode {
                        playList
    //                        .transition(.move(edge: .trailing))
                    }
                }
                    .padding()
                    .padding(.top, 250)
            }
                .navigationBarHidden(true)
                .background(Color.theme.background)
                .foregroundColor(Color.theme.primaryText)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
    }
}

extension HomeView {
    private var menuList: some View {
        VStack (alignment: .leading, spacing: 20) {
            NavigationLink(tag: "instruction", selection: $menuSelection) {
                HowToPlayView()
            } label: {
                EmptyView()
            }
            NavigationLink(tag: "leaderboard", selection: $menuSelection) {
                LeaderboardView()
            } label: {
                EmptyView()
            }
            NavigationLink(tag: "settings", selection: $menuSelection) {
                SettingsView()
            } label: {
                EmptyView()
            }

            Button {
                isSelectingPlayMode.toggle()
            } label: {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.theme.primaryText, lineWidth: 3)
                    .overlay(
                    Text(menuOptions["play"]!)
                        .font(.headline)
                )
                    .frame(height: 55)
            }
                .controlSize(.regular)
                .cornerRadius(20)

            Button {
                menuSelection = "instruction"
            } label: {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.theme.primaryText, lineWidth: 3)
                    .overlay(
                    Text(menuOptions["instruction"]!)
                        .font(.headline)
                )
                    .frame(height: 55)
            }
                .controlSize(.regular)
                .cornerRadius(20)

            Button {
                menuSelection = "leaderboard"
            } label: {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.theme.primaryText, lineWidth: 3)
                    .overlay(
                    Text(menuOptions["leaderboard"]!)
                        .font(.headline)
                )
                    .frame(height: 55)
            }
                .controlSize(.regular)
                .cornerRadius(20)

            Button {
                menuSelection = "settings"
            } label: {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.theme.primaryText, lineWidth: 3)
                    .overlay(
                    Text(menuOptions["settings"]!)
                        .font(.headline)
                )
                    .frame(height: 55)
            }
                .controlSize(.regular)
                .cornerRadius(20)
        }
    }
    private var playList: some View {
        VStack (alignment: .leading, spacing: 20) {
            NavigationLink(tag: "bot", selection: $playSelection) {
                DeployView()
            } label: {
                EmptyView()
            }
            NavigationLink(tag: "practice", selection: $playSelection) {
                PracticeView()
            } label: {
                EmptyView()
            }

            Button {
                playSelection = "bot"
            } label: {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.theme.primaryText, lineWidth: 3)
                    .overlay(
                    Text(playOptions["bot"]!)
                        .font(.headline)
                )
                    .frame(height: 55)
            }
                .controlSize(.regular)
                .cornerRadius(20)

            Button {
                playSelection = "practice"
            } label: {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.theme.primaryText, lineWidth: 3)
                    .overlay(
                    Text(playOptions["practice"]!)
                        .font(.headline)
                )
                    .frame(height: 55)
            }
                .controlSize(.regular)
                .cornerRadius(20)

            Button {
                isSelectingPlayMode.toggle()
            } label: {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.theme.primaryText, lineWidth: 3)
                    .overlay(
                    Text(playOptions["back"]!)
                        .font(.headline)
                )
                    .frame(height: 55)
            }
                .controlSize(.regular)
                .cornerRadius(20)
        }
            .padding(.top, -55)
    }

}
