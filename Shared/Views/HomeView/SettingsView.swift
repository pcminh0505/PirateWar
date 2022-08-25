//
//  SettingsView.swift
//  PirateWar
//
//  Created by Minh Pham on 09/08/2022.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode

    @State var difficulty: Difficulty = .easy

    var body: some View {
        ZStack {
            VStack (alignment: .center, spacing: 20) {
                Text("Appearance and Sounds")
                    .font(.title3)
                    .bold()

                Toggle(isOn: .constant(true)) {
                    Text("Dark Mode")
                        .foregroundColor(Color.theme.secondaryText)
                }
                Toggle(isOn: .constant(true)) {
                    Text("Background Music")
                        .foregroundColor(Color.theme.secondaryText)
                }
                Toggle(isOn: .constant(true)) {
                    Text("Sound Effect")
                        .foregroundColor(Color.theme.secondaryText)
                }


                Text("AI Difficulty")
                    .font(.title3)
                    .bold()
                Picker("Choose Difficulty", selection: $difficulty) {
                    ForEach(Difficulty.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                    .pickerStyle(SegmentedPickerStyle())

                Text("Account Management")
                    .font(.title3)
                    .bold()


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

enum Difficulty: String, CaseIterable {
    case noob = "Noob"
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"
}
