//
//  HomeView.swift
//  PirateWar
//
//  Created by Minh Pham on 09/08/2022.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var navigationHelper: NavigationHelper

    @State var showSettingsView: Bool = false // New Sheet
    @State var showInfoView: Bool = false // New Sheet

    var body: some View {
        // Should use NavigationStack on newer version
        NavigationView {
            ZStack {
                // Background layer
                Color.theme.background
                    .ignoresSafeArea()
                    .sheet(isPresented: $showSettingsView) {
                    SettingsView()
                }


                LottieView(name: "pirates", loopMode: .loop)
                    .padding(.top, -UIScreen.main.bounds.height * 0.25)
                VStack {
                    HStack {
                        Button {
                            showSettingsView.toggle()
                        } label: {
                            Image(systemName: "gearshape")
                        }
                        Spacer()
                        Button {
                            showInfoView.toggle()
                        } label: {
                            Image(systemName: "info.circle")
                        }

                    }
                        .font(.title2)
                    Spacer()


                    menuList
                        .padding(.top, UIScreen.main.bounds.height * 0.4)

                    Spacer()
                }
                    .padding(30)


            }
                .navigationBarHidden(true)
                .foregroundColor(Color.theme.primaryText)
        }
            .navigationViewStyle(.stack)
            .onAppear {
            BackgroundManager.instance.startPlayer(track: "homebackground", loop: true)
        }
            .sheet(isPresented: $showInfoView) {
            InfoView()
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
            Button {
                navigationHelper.selection = "bot"
            } label: {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.theme.primaryText, lineWidth: 3)
                    .overlay(
                    Text("🕹 Player vs AI")
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

            NavigationLink(tag: "leaderboard", selection: $navigationHelper.selection) {
                LeaderboardView()
            } label: {
                EmptyView()
            }
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
