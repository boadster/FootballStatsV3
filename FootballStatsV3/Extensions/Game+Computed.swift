//
//  Game+Computed.swift
//  FootballStatsV3
//
//  Created by Aaron Bodell on 7/23/25.
//

import Foundation

extension Game {
    var displayName: String {
        let opponent = opponentName ?? "Opponent"
        let dateString = formattedDate ?? "Date Unknown"
        return "\(location == "Away" ? "@" : "vs") \(opponent) on \(dateString)"
    }

    private var formattedDate: String? {
        guard let date = date else { return nil }
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
    
    var playArray: [Play] {
        (plays as? Set<Play>)?.sorted { $0.clockTime < $1.clockTime } ?? []
    }
}

