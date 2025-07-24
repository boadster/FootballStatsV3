//
//  PossessionUtils.swift
//  FootballStats2
//

import SwiftUI

struct PossessionUtils {
    /// Returns 0...1 for bar progress, always from "own" side for team with ball.
    static func yardlineProgress(ballOn: Int, offenseIsOnLeft: Bool) -> CGFloat {
        let normalized = offenseIsOnLeft ? ballOn : 100 - ballOn
        return CGFloat(normalized) / 100.0
    }

    /// Returns a display string like "Own 24" or "Opponent 43" based on who has the ball and which side they are on.
    static func formattedYardline(ballOn: Int, offenseIsOnLeft: Bool) -> String {
        let normalized = offenseIsOnLeft ? ballOn : 100 - ballOn
        let side = normalized <= 50 ? "Own" : "Opponent"
        let shown = normalized <= 50 ? normalized : 100 - normalized
        return "\(side) \(shown)"
    }
}
