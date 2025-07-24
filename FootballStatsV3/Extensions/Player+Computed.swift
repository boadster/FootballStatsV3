//
//  Player+Computed.swift
//  FootballStats2
//
//  Created by Aaron Bodell on 7/19/25.
//

import Foundation
import SwiftData

extension Player {
    var fullName: String {
        "\(firstName) \(lastName)"
    }

//    var isStarter: Bool {
//        starterOrder == 1
//    }
//
//    var position: Position {
//        Position(rawValue: positionRaw) ?? .other
//    }
//
//    var gradeLevel: GradeLevel {
//        GradeLevel(rawValue: gradeLevelRaw) ?? .freshman
//    }
//
//    var positionGroup: PositionGroup? {
//        guard let raw = positionGroupRaw else { return nil }
//        return PositionGroup(rawValue: raw)
//    }
}
