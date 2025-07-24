//
//  Team.swift
//  FootballStatsV3
//
//  Created by Aaron Bodell on 7/23/25.
//

import Foundation
import SwiftData

@Model
class Team {
    @Attribute(.unique) var id: UUID
    var teamInfo: TeamInfo
    var isUserTeam: Bool  // Indicates "My Team" vs opponent

    init(id: UUID = UUID(), teamInfo: TeamInfo, isUserTeam: Bool = false) {
        self.id = id
        self.teamInfo = teamInfo
        self.isUserTeam = isUserTeam
    }
}

// Struct for embedded team information
struct TeamInfo: Codable, Hashable, Sendable {
    var schoolName: String
    var mascot: String
    var shortName: String?
    var city: String
    var state: String
    var classification: String? // e.g. 3A, 4A, etc.
    var region: String?         // e.g. Region 10
    var colorPrimaryHex: String?
    var colorSecondaryHex: String?
}
