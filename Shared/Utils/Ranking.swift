//
//  Ranking.swift
//  PirateWar (iOS)
//
//  Created by Minh Pham on 26/08/2022.
//

import Foundation

class RankingHelper {
    static func getBadgeFromScore(score: Int) -> String {
        if score >= 450 { return "Gold" }
        else if score >= 300 { return "Silver" }
        else if score >= 150 { return "Bronze" }
        else { return "Iron" }
    }
}
