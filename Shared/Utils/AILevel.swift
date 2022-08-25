//
//  AILevel.swift
//  PirateWar (iOS)
//
//  Created by Minh Pham on 25/08/2022.
//

import Foundation

class AIModelManager {
    static func getBotLevel(bot: String?) -> AIModel {
        switch bot {
        case "Noob":
            return SequentialAIModel()
        case "Easy":
            return RandomAIModel()
        case "Medium":
            return HuntAIModel()
        case "Hard":
            return HuntParityAIModel()
        default:
            return RandomAIModel()
        }
    }
}
