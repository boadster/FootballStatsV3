//
//  Penalty+Enums.swift
//  FootballStats2
//
//  Created by Aaron Bodell on 7/13/25.
//

import Foundation

enum PenaltyType: String, Codable, CaseIterable {
    case holding
    case faceMask
    case offside
    case falseStart
    case passInterference
    case personalFoul
    case unsportsmanlikeConduct
    case delayOfGame
    case illegalFormation
    case illegalMotion
    case blockInTheBack
    case roughingThePasser
    case roughingTheKicker
    case horseCollar
    case chopBlock
    case targeting
    case sidelineInfraction
    case encroachment
    case illegalSubstitution
    case illegalShift
    case illegalBlock
    case other
}

enum PenaltyStatus: String, Codable, CaseIterable {
    case accepted
    case declined
    case offsetting
}
