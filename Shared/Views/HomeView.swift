//
//  HomeView.swift
//  PirateWar
//
//  Created by Minh Pham on 09/08/2022.
//

import SwiftUI

struct HomeView: View {
    private var menuOptions: [String] = [
        "🕹 Play",
        "📖 How to Play",
        "🏆 Leaderboard",
        "⚙️ Settings",
    ]
    @State private var selection: String? = nil

    var body: some View {
        ZStack {
            LottieView(name: "pirates", loopMode: .loop)
                .padding(.top, -350)

            VStack (alignment: .leading, spacing: 10) {
                ForEach(menuOptions, id: \.self) { option in
                    NavigationLink(tag: option, selection: $selection) {
                        PlayView() // Hardcode for now
                    } label: {
                        EmptyView()
                    }

                    Button {
                        self.selection = option
                    } label: {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.theme.primaryText, lineWidth: 3)
                            .overlay(
                                Text(option)
                                .font(.headline)
                        )
                            .frame(height: 55)
                    }
                        .controlSize(.regular)
//                        .background(Color.theme.secondaryText)
                    .cornerRadius(20)
                }
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
