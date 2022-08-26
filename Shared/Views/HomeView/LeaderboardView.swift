//
//  LeaderboardView.swift
//  PirateWar
//
//  Created by Minh Pham on 09/08/2022.
//

import SwiftUI

struct LeaderboardView: View {
    var body: some View {
        
        VStack {
            Text("🏆 Leaderboard 🏅")
                .font(.title2)
                .bold()
            Spacer()
            
            VStack(alignment: .center, spacing: 20) {
                VStack {
                    Text("⭐️⭐️⭐️⭐️ Master ⭐️⭐️⭐️⭐️")
                    Text("450+")
                        .font(.caption)
                }
                
                VStack {
                    Text("⭐️⭐️⭐️ Captain ⭐️⭐️⭐️")
                    Text("300+")
                        .font(.caption)
                }
                
                VStack {
                    Text("⭐️⭐️ Pirate ⭐️⭐️")
                    Text("150+")
                        .font(.caption)
                }

                VStack {
                    Text("⭐️ Seadog ⭐️")
                }
            }
            
            Spacer()
        }
//        .padding()
        .navigationBarHidden(true)
    }
}

struct LeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardView()
    }
}
