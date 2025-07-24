//
//  Penalty.swift
//  FootballStatsV3
//
//  Created by Aaron Bodell on 7/23/25.
//

import Foundation

struct Penalty: Codable, Hashable, Sendable {
    var type: PenaltyType
    var status: PenaltyStatus
    var yards: Int
    var isEnforced: Bool
}
