//
//  Team+Computed.swift
//  FootballStatsV3
//
//  Created by Aaron Bodell on 7/24/25.
//

import Foundation
import SwiftUI

extension TeamInfo {
    var displayName: String {
        if let nickname = shortName, !nickname.isEmpty {
            return nickname
        } else {
            return schoolName
        }
    }
    
    var fullLocation: String {
        "\(city), \(state)"
    }
    
    var classificationRegion: String {
        "\(classification ?? "") - Region \(region ?? "")"
    }
    
    var primaryColor: Color {
        Color(hex: colorPrimaryHex ?? "#000000")
    }
    
    var secondaryColor: Color {
        Color(hex: colorSecondaryHex ?? "#FFFFFF")
    }
}

