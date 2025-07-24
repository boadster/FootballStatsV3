//
//  Play.swift
//  FootballStatsV3
//
//  Created by Aaron Bodell on 7/23/25.
//

import Foundation
import SwiftData

@Model
class Play {
    @Attribute(.unique) var id: UUID
    var playType: PlayType
    var playResult: PlayResult
    var startYardline: Int
    var endYardline: Int
    var players: [PlayerRole]
    var penalties: [Penalty]
    var note: String
    var gameID: UUID

    init(
        id: UUID = UUID(),
        playType: PlayType,
        playResult: PlayResult,
        startYardline: Int,
        endYardline: Int,
        players: [PlayerRole] = [],
        penalties: [Penalty] = [],
        note: String = "",
        gameID: UUID
    ) {
        self.id = id
        self.playType = playType
        self.playResult = playResult
        self.startYardline = startYardline
        self.endYardline = endYardline
        self.players = players
        self.penalties = penalties
        self.note = note
        self.gameID = gameID
    }
}
