//
//  Play+Computed.swift
//  FootballStats2
//
//  Created by Aaron Bodell on 4/6/25.
//

import Foundation

extension Play {
    var yardage: Int {
        endYardline - startYardline
    }

    var isPAT: Bool {
        playType == .extraPoint || playType == .twoPointConversion
    }

    var isKickoff: Bool {
        playType == .kickoff || playType == .onsideKick
    }

    var isReturn: Bool {
        [.puntReturn, .kickReturn].contains(playType)
    }

    var isFieldGoalAttempt: Bool {
        playType == .fieldGoal
    }

    var isTouchdown: Bool {
        playResult == .touchdown
    }

    var isTurnover: Bool {
        [.interception, .fumbleLost, .turnoverOnDowns].contains(playResult)
    }

    var isFirstDown: Bool {
        playResult == .firstDown
    }

    var playersInvolved: [UUID] {
        players.map { $0.playerId }
    }
}
