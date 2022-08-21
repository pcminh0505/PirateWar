//
//  HomeView.swift
//  PirateWar
//
//  Created by Minh Pham on 09/08/2022.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var navigationHelper: NavigationHelper

    @State var isSelectingPlayMode: Bool = false

    var body: some View {
        NavigationView {
            ZStack {
                LottieView(name: "pirates", loopMode: .loop)
                    .padding(.top, -350)
                VStack {
                    if !isSelectingPlayMode {
                        menuList
                            .transition(.move(edge: .leading))
                    }
                    if isSelectingPlayMode {
                        playList
                            .transition(.move(edge: .trailing))
                    }
                }
                    .padding()
                    .padding(.top, 250)
            }
                .navigationBarHidden(true)
                .background(Color.theme.background)
                .foregroundColor(Color.theme.primaryText)
        }
            .onAppear {
            BackgroundManager.instance.startPlayer(track: "homebackground", loop: true)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
            .environmentObject(NavigationHelper())
    }
}

extension HomeView {
    private var menuList: some View {
        VStack (alignment: .leading, spacing: 15) {
//            NavigationLink(tag: "instruction", selection: $navigationHelper.selection) {
//                HowToPlayView()
//            } label: {
//                EmptyView()
//            }
//            Button {
//                navigationHelper.selection = "instruction"
//            } label: {
//                RoundedRectangle(cornerRadius: 20)
//                    .stroke(Color.theme.primaryText, lineWidth: 3)
//                    .overlay(
//                    Text("📖 How to Play")
//                        .font(.headline)
//                )
//                    .frame(height: 55)
//            }
//                .controlSize(.regular)
//                .cornerRadius(20)
            Button {
                withAnimation(Animation.easeInOut(duration: 0.1), {
                    isSelectingPlayMode.toggle()
                })
            } label: {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.theme.primaryText, lineWidth: 3)
                    .overlay(
                    Text("🕹 Play")
                        .font(.headline)
                )
                    .frame(height: 55)
            }
                .controlSize(.regular)
                .cornerRadius(20)

            Button {
                navigationHelper.selection = "leaderboard"
            } label: {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.theme.primaryText, lineWidth: 3)
                    .overlay(
                    Text("🏆 Leaderboard")
                        .font(.headline)
                )
                    .frame(height: 55)
            }
                .controlSize(.regular)
                .cornerRadius(20)

            Button {
                navigationHelper.selection = "settings"
            } label: {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.theme.primaryText, lineWidth: 3)
                    .overlay(
                    Text("⚙️ Settings")
                        .font(.headline)
                )
                    .frame(height: 55)
            }
                .controlSize(.regular)
                .cornerRadius(20)

            NavigationLink(tag: "leaderboard", selection: $navigationHelper.selection) {
                LeaderboardView()
            } label: {
                EmptyView()
            }
            NavigationLink(tag: "settings", selection: $navigationHelper.selection) {
                SettingsView()
            } label: {
                EmptyView()
            }
        }
    }
    private var playList: some View {
        VStack (alignment: .leading, spacing: 15) {
            Button {
                navigationHelper.selection = "bot"
            } label: {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.theme.primaryText, lineWidth: 3)
                    .overlay(
                    Text("🤖 Single Player (vs AI)")
                        .font(.headline)
                )
                    .frame(height: 55)
            }
                .controlSize(.regular)
                .cornerRadius(20)
            Button {
                navigationHelper.selection = "practice"
            } label: {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.theme.primaryText, lineWidth: 3)
                    .overlay(
                    Text("🎯 Practice")
                        .font(.headline)
                )
                    .frame(height: 55)
            }
                .controlSize(.regular)
                .cornerRadius(20)

            Button {
                withAnimation(Animation.easeInOut(duration: 0.1), {
                    isSelectingPlayMode.toggle()
                })
            } label: {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.theme.primaryText, lineWidth: 3)
                    .overlay(
                    Text("⬅ Back")
                        .font(.headline)
                )
                    .frame(height: 55)
            }
                .controlSize(.regular)
                .cornerRadius(20)

            NavigationLink(tag: "bot", selection: $navigationHelper.selection) {
                DeployView()
            } label: {
                EmptyView()
            }.isDetailLink(false)
            NavigationLink(tag: "practice", selection: $navigationHelper.selection) {
                PracticeView()
            } label: {
                EmptyView()
            }.isDetailLink(false)
        }
    }

}
