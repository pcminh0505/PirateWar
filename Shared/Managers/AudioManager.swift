//
//  AudioManager.swift
//  PirateWar (iOS)
//
//  Created by Minh Pham on 13/08/2022.
//

import Foundation
import AVKit

final class AudioManager {
    static let instance = AudioManager()
    var player: AVAudioPlayer?

    func startPlayer(track: String) {
        guard let url = Bundle.main.url(forResource: track, withExtension: "mp3")
            else { return }

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("Fail to initialize player", error)
        }
    }
}
