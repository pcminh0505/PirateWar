//
//  PirateWarApp.swift
//  Shared
//
//  Created by Minh Pham on 09/08/2022.
//

import SwiftUI

@main
struct PirateWarApp: App {
    @StateObject var users = Users()
    var body: some Scene {
        WindowGroup {
            LaunchView()
                .environmentObject(NavigationHelper())
                .environmentObject(users)
        }
    }
}
