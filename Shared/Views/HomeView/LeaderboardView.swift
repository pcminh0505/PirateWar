//
//  LeaderboardView.swift
//  PirateWar
//
//  Created by Minh Pham on 09/08/2022.
//

import SwiftUI

struct LeaderboardView: View {
    @EnvironmentObject var users: Users
    let ranking: [(title: String, points: Int)] = [("Gold", 450), ("Silver", 300), ("Bronze", 150), ("Iron", 0)]

    let rows: [GridItem] = [
        GridItem(.flexible(), alignment: .leading),
        GridItem(.flexible(), alignment: .center),
        GridItem(.flexible(), alignment: .trailing),
    ]

    var body: some View {
        ZStack {
            let allUsers = users.users.keys.map { $0 }
            Color.theme.background
                .ignoresSafeArea()

            ScrollView {
                Text("🏆 Leaderboard 🏅")
                    .font(.title2)
                    .bold()
                    .padding(.bottom, 20)

                VStack(alignment: .center, spacing: 10) {
                    ForEach(Array(allUsers.sorted { users.users[$0] ?? 0 > users.users[$1] ?? 0 }.enumerated()), id: \.offset) { index, name in
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .strokeBorder(Color.theme.primaryText, lineWidth: 1)
                                .background(RoundedRectangle(cornerRadius: 15).foregroundColor(name == users.activeUser ? Color.theme.woodBackground : Color.clear))

                            LazyVGrid(columns: rows) {
                                HStack {
                                    Text("\(index + 1)")
                                        .font(.headline)
                                    Image(RankingHelper.getBadgeFromScore(score: users.users[name] ?? 0))
                                        .resizable()
                                        .frame(width: 30, height: 40)
                                }
                                
                                Text(name)
                                    .font(.headline)
                                Text("\(users.users[name] ?? 0)")
                            }
                            .padding(10)

                        }
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                Spacer()
            }
                .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .center
            )
                .padding()
        }.overlay(
            XMarkButton()
                .padding(.top, 20)
                .padding(.leading, 20)
            , alignment: .topLeading
        )
            .navigationBarHidden(true)
    }
}

struct LeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardView()
            .environmentObject(Users())
    }
}
