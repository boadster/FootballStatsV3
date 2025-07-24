//
//  Game.swift
//  FootballStatsV3
//
//  Created by Aaron Bodell on 7/23/25.
//

import Foundation
import SwiftData

@Model
class Game {
    @Attribute(.unique) var id: UUID
    var date: Date
    var opponentName: String
    var isHome: Bool
    var isComplete: Bool
    var plays: [Play]  // This will work once Play is also @Model
    @Relationship var team: Team?
    var opponentTeam: TeamInfo?

    init(
        id: UUID = UUID(),
        date: Date,
        opponentName: String,
        isHome: Bool,
        isComplete: Bool = false,
        plays: [Play] = [],
        team: Team? = nil,
        opponentTeam: TeamInfo? = nil
    ) {
        self.id = id
        self.date = date
        self.opponentName = opponentName
        self.isHome = isHome
        self.isComplete = isComplete
        self.plays = plays
        self.team = team
        self.opponentTeam = opponentTeam
    }

    var displayName: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return "\(formatter.string(from: date)) vs \(opponentName)"
    }
}
