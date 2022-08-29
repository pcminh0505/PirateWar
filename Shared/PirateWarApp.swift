/*
    RMIT University Vietnam
    Course: COSC2659 iOS Development
    Semester: 2022B
    Assessment: Assignment 2
    Author: Pham Cong Minh
    ID: s3818102
    Created  date: 09/08/2022
    Last modified: 29/08/2022
    Acknowledgement: Mobiraft (https://mobiraft.com/ios/swiftui/how-to-add-splash-screen-in-swiftui/)
*/

import SwiftUI

@main
struct PirateWarApp: App {
    @StateObject var users = Users()
    
    init() {
        UserDefaults.standard.register(defaults: [
            "backgroundMusic": true,
            "soundEffect": true,
        ])
    }
    var body: some Scene {
        WindowGroup {
            LaunchView()
                .environmentObject(NavigationHelper())
                .environmentObject(users)
        }
    }
}
