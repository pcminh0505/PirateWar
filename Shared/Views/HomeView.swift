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
    @State private var selection: String? = nil

    var body: some View {
        ZStack {
            LottieView(name: "pirates", loopMode: .loop)
                .padding(.top, -350)

            VStack (alignment: .leading, spacing: 10) {
                NavigationLink(tag: "play", selection: $selection) {
                    PlayView()
                } label: {
                    EmptyView()
                }
                NavigationLink(tag: "instruction", selection: $selection) {
                    HowToPlayView()
                } label: {
                    EmptyView()
                }
                NavigationLink(tag: "leaderboard", selection: $selection) {
                    LeaderboardView()
                } label: {
                    EmptyView()
                }
                NavigationLink(tag: "settings", selection: $selection) {
                    SettingsView()
                } label: {
                    EmptyView()
                }


                Button {
                    self.selection = "play"
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
                    self.selection = "instruction"
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
                    self.selection = "leaderboard"
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
                    self.selection = "settings"
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
                .padding()
                .padding(.top, 250)

        }
            .background(Color.theme.background)
            .foregroundColor(Color.theme.primaryText)



    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
    }
}
