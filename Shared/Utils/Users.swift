//
//  Users.swift
//  PirateWar (iOS)
//
//  Created by Minh Pham on 26/08/2022.
//

import Foundation

// Favorites class keep track of favorite list accross the app
class Users: ObservableObject {
    var users: [String: Int]
    var activeUser: String

    private let saveUsersKey = "Users"
    private let saveActiveUserKey = "ActiveUser"

    init() {
        // Load from UserDefault
        users = UserDefaults.standard.object(forKey: saveUsersKey) as? [String: Int] ?? ["Guest": 0]
        activeUser = UserDefaults.standard.string(forKey: saveActiveUserKey) ?? "Guest"
    }

    func getCurrentUser() -> (String, Int) {
        return (activeUser, users[activeUser] ?? 0)
    }

    func isOnlyGuest() -> Bool {
        if activeUser == "Guest" && users.count == 1 {
            if let _ = users["Guest"] {
                return true
            }
        }
        return false
    }

    func migrateAccount(name: String, highScore: Int) {
        // Only call when there's only guest account
        users.removeAll()
        users[name] = highScore
        activeUser = name
        save()
    }

    func switchUser(name: String) {
        if let _ = users[name] {
            // Change user
            activeUser = name
            save()
        } else {
            // Add new user
            users[name] = 0
            save()
        }
    }

    func updateHighscore(newScore: Int) {
        if let currentScore = users[activeUser] {
            users[activeUser] = max(currentScore, newScore)
            save()
        }
    }

    func save() {
        UserDefaults.standard.set(users, forKey: saveUsersKey)
        UserDefaults.standard.set(activeUser, forKey: saveActiveUserKey)
    }
}
