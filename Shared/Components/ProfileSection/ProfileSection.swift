//
//  ProfileSection.swift
//  PirateWar (iOS)
//
//  Created by Minh Pham on 26/08/2022.
//

import SwiftUI

struct ProfileSection: View {
    @EnvironmentObject var users: Users
    @State private var presentAlert = false
    @State private var username: String = ""

    var body: some View {
        let user: (String, Int) = users.getCurrentUser()

        ZStack {
            InvertCornerRectangle()
                .fill(Color.theme.woodBackground)
            VStack(alignment: .center) {
                HStack {
                    Image(RankingHelper.getBadgeFromScore(score: user.1))
                        .resizable()
                        .frame(width: 80, height: 100)
                        .padding(.leading, -20)
                    VStack (alignment: .leading, spacing: 10) {
                        Text(user.0)
                            .font(.title2)
                            .bold()
                        Text("Title: \(RankingHelper.getBadgeFromScore(score: user.1))")
                            .font(.callout)
                            .bold()
                        Text("\(user.1) points")
                            .font(.body)
                    }
                }

                Button {
                    withAnimation(.spring()) {
                        presentAlert.toggle()
                    }
                } label: {
                    Text(users.isOnlyGuest() ? "Change Name" : "Switch User")
                        .foregroundColor(Color.theme.blue)
                }

                if presentAlert {
                    VStack {
                        TextField("Enter username", text: $username)
                            .textFieldStyle(.plain)
                            .frame(width: UIScreen.main.bounds.width * 0.5, height: nil)
                            .multilineTextAlignment(.center)
                        if username != "" {
                            Button {
                                users.isOnlyGuest() ? users.migrateAccount(name: username, highScore: user.1) : users.switchUser(name: username)
                                withAnimation(.spring()) {
                                    presentAlert.toggle()
                                }
                            } label: {
                                Text(users.isOnlyGuest() ? "Save" : "Switch")
                                    .foregroundColor(Color.theme.blue)
                            }
                        }
                    }
                }
            }
                .padding()
        }
            .fixedSize(horizontal: false, vertical: true)
    }
}

struct ProfileSection_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSection()
            .environmentObject(Users())
    }
}
