//
//  PlayType+Computed.swift
//  FootballStats2
//
//  Created by Aaron Bodell on 4/6/25.
//

import Foundation

enum PlayType: String, CaseIterable, Codable, Hashable {
    case pass, rush, scramble, kneel, spike, twoPointConversion
    case kickoff, punt, onsideKick, puntReturn, kickReturn
    case fieldGoal, extraPoint, penalty, timeout, special
    case defensivePlay, other
}

enum PlayResult: String, Codable, CaseIterable, Hashable {
    case firstDown, touchdown, safety, incomplete, gain, passComplete
    case turnoverOnDowns, interception, fumbleLost, fumbleRecovered
    case tackle, other, touchback, returned, fairCatch, downed
    case outOfBounds, blocked, missed, good, onsideRecovered, onsideNotRecovered
    case penalty, declined, offsetting, noPlay
}

enum PlayerRoleType: String, Codable, Hashable {
    // Offense
    case passer, rusher, receiver, intendedReceiver, fumbler, fumbleRecoverer, blocker

    // Defense
    case tackler, assister, sacker, interceptor, passBreaker
    case fumbleRecovery, forcedFumble, qbHurry, returnTackler

    // Special Teams
    case kicker, punter, returner, longSnapper, holder
    case patKickBlock, fgBlock, kickCoverTackler, onsideRecovery

    // General
    case penaltyOn, penaltyDrawnBy, scorer, other
}

extension PlayResult {
    var displayName: String {
        return rawValue.replacingOccurrences(of: "([a-z])([A-Z])", with: "$1 $2", options: .regularExpression).capitalized
    }
}

extension PlayType {
    static var offensivePlays: [PlayType] {
        [.rush, .pass, .spike, .kneel]
    }
    
    static var specialTeamsPlays: [PlayType] {
        [.kickoff, .punt, .fieldGoal, .extraPoint, .twoPointConversion]
    }

    var displayName: String {
        switch self {
        case .twoPointConversion:
            return "2PT"
        default:
            return rawValue.replacingOccurrences(of: "([a-z])([A-Z])", with: "$1 $2", options: .regularExpression).capitalized
        }
    }
    
    static var returnPlays: [PlayType] {
        [.puntReturn, .kickReturn]
    }
    
    var requiresYards: Bool {
        switch self {
        case .rush, .pass, .twoPointConversion:
            return true
        default:
            return false
        }
    }

    var validResults: [PlayResult] {
        switch self {
        case .pass:
            return [.incomplete, .touchdown, .interception, .fumbleLost]
        case .rush, .kneel:
            return [.touchdown, .fumbleLost]
        case .spike:
            return [.incomplete]
        case .twoPointConversion:
            return [.good, .missed]
        case .scramble:
            return []
        case .kickoff:
            return [.touchback, .outOfBounds]
        case .punt:
            return [.touchback, .outOfBounds, .blocked]
        case .onsideKick:
            return [.onsideRecovered, .onsideNotRecovered]
        case .puntReturn:
            return [.fairCatch, .touchdown, .fumbleLost, .fumbleRecovered, .returned]
        case .kickReturn:
            return [.fairCatch, .touchdown, .fumbleLost, .fumbleRecovered, .returned]
        case .fieldGoal:
            return [.good, .missed]
        case .extraPoint:
            return [.good, .missed]
        case .penalty:
            return []
        case .timeout:
            return []
        case .special:
            return []
        case .defensivePlay:
            return []
        case .other:
            return []
        }
    }
}

extension PlayerRoleType {
    var displayLabel: String {
        switch self {
        case .tackler: return "Tackler"
        case .sacker: return "Sacker"
        case .interceptor: return "Interceptor"
        case .passBreaker: return "Pass Breakup"
        case .fumbleRecovery: return "Fumble Recovery"
        case .forcedFumble: return "Forced Fumble"
        case .qbHurry: return "QB Hurry"
        default: return rawValue.capitalized
        }
    }
}
