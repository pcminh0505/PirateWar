//
//  Time.swift
//  PirateWar (iOS)
//
//  Created by Minh Pham on 21/08/2022.
//

import Foundation

class TimeHelper {
    static func secondsToHoursMinutesSeconds(_ seconds: Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 60))
    }
    
    static func printSecondsToTimeNumber(_ seconds: Int) -> String {
      let (h, m, s) = secondsToHoursMinutesSeconds(seconds)
      return "\(String(format: "%02d", h)):\(String(format: "%02d", m)):\(String(format: "%02d", s))"
    }
}
