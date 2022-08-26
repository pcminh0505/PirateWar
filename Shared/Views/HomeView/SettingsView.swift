//
//  SettingsView.swift
//  PirateWar
//
//  Created by Minh Pham on 09/08/2022.
//
import Combine
import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("difficulty") var difficulty: Difficulty = .easy
    @AppStorage("backgroundMusic") var backgroundMusic = true
    @AppStorage("soundEffect") var soundEffect = true

//    @AppStorage("users") var users: [String: Int] =
    var body: some View {
//        let _ = print("Background Music", backgroundMusic)
//        let _ = print("Sound Effect", soundEffect)
        ZStack {
            VStack (alignment: .center, spacing: 25) {
                Text("Sounds")
                    .font(.title3)
                    .bold()
                Toggle(isOn: $backgroundMusic) {
                    Text("Background Music")
                        .foregroundColor(Color.theme.secondaryText)
                }
                    .onChange(of: backgroundMusic) { value in
                    // Effect immediately
                    BackgroundManager.instance.player?.volume = value ? 1.0 : 0.0
                }
                Toggle(isOn: $soundEffect) {
                    Text("Sound Effect")
                        .foregroundColor(Color.theme.secondaryText)
                }
                    .onChange(of: soundEffect) { value in
                    // Effect immediately
                    SoundEffectManager.instance.player?.volume = value ? 1.0 : 0.0
                }


                Text("AI Difficulty")
                    .font(.title3)
                    .bold()
                Picker("AI Difficulty", selection: $difficulty, content: {
                    ForEach(Difficulty.allCases, id: \.self, content: { item in
                        Text(item.rawValue).tag(item)
                    })
                })
                    .pickerStyle(SegmentedPickerStyle())

                Text("Account Management")
                    .font(.title3)
                    .bold()
                ProfileSection()
                Spacer()
            }
                .padding(50)
                .foregroundColor(Color.theme.primaryText)
                .background(Color.theme.background)

        }
            .overlay(
            XMarkButton()
                .padding(.top, 20)
                .padding(.trailing, 20)
            , alignment: .topTrailing
        )
            .navigationBarHidden(true)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .preferredColorScheme(.dark)
    }
}

enum Difficulty: String, CaseIterable, Codable {
    case noob = "Noob"
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"
}
