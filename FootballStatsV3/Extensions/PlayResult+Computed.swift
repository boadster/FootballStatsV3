//
//  PlayResult+Computed.swift
//  FootballStats2
//
//  Created by Aaron Bodell on 4/22/25.
//

import Foundation

extension PlayResult {
    static var offensiveResults: [PlayResult] {
        [.firstDown, .touchdown, .turnoverOnDowns, .interception, .fumbleLost, .incomplete, .safety, .fumbleRecovered]
    }

    static var specialTeamsResults: [PlayResult] {
        [.touchback, .returned, .fairCatch, .downed, .outOfBounds, .blocked, .missed, .good, .onsideRecovered, .onsideNotRecovered]
    }

    static var universalResults: [PlayResult] {
        [.penalty, .declined, .offsetting, .noPlay]
    }

    var displayLabel: String {
        rawValue.replacingOccurrences(of: "([a-z])([A-Z])", with: "$1 $2", options: .regularExpression).capitalized
    }
    
    var generatesYards: Bool {
       switch self {
       case .gain, .passComplete:
         return true
       default:
         return false
       }
     }
}
