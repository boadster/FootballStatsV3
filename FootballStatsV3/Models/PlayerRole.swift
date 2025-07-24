//
//  PlayerRole.swift
//  FootballStatsV3
//
//  Created by Aaron Bodell on 7/23/25.
//

import Foundation

struct PlayerRole: Codable, Hashable, Sendable {
    var playerId: UUID
    var role: PlayerRoleType
    var yardsGained: Int?
    var isPrimary: Bool?
    var note: String?
}
