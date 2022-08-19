//
//  AudioManager.swift
//  PirateWar (iOS)
//
//  Created by Minh Pham on 13/08/2022.
//

// Credit PixaBay

import Foundation
import AVKit

final class AudioManager {
    static let instance = AudioManager()
    var player: AVAudioPlayer?

    func startPlayer(track: String, loop: Bool, speed: Float = 1.0) {
        guard let url = Bundle.main.url(forResource: track, withExtension: "mp3")
            else {
            print("Resource not found!")
            return
        }

        do {
            player = try AVAudioPlayer(contentsOf: url)
            if (loop) {
                player?.numberOfLoops = -1
            }
            player?.enableRate = true
            player?.rate = speed
            player?.play()
        } catch {
            print("Fail to initialize player", error)
        }
    }
}
