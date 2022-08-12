//
//  PirateWarApp.swift
//  Shared
//
//  Created by Minh Pham on 09/08/2022.
//

import SwiftUI

@main
struct PirateWarApp: App {
    @StateObject private var game = Game()
    var body: some Scene {
        WindowGroup {
            LaunchView()
                .environmentObject(game)
        }
    }
}
