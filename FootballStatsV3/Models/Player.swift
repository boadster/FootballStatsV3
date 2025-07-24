//
//  Player.swift
//  FootballStatsV3
//
//  Created by Aaron Bodell on 7/23/25.
//

import Foundation
import SwiftData

@Model
class Player {
    @Attribute(.unique) var id: UUID
    var firstName: String
    var lastName: String
    var jerseyNumber: Int
    var position: String
    var height: String
    var weight: String
    var gradeLevel: String
    var teamID: UUID

    init(
        id: UUID = UUID(),
        firstName: String,
        lastName: String,
        jerseyNumber: Int,
        position: String,
        height: String,
        weight: String,
        gradeLevel: String,
        teamID: UUID
    ) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.jerseyNumber = jerseyNumber
        self.position = position
        self.height = height
        self.weight = weight
        self.gradeLevel = gradeLevel
        self.teamID = teamID
    }
}
