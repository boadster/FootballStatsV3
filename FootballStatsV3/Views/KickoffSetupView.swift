//
//  KickoffSetupView.swift
//  FootballStatsV3
//
//  Created by Aaron Bodell on 7/23/25.
//


import SwiftUI
import SwiftData
import Foundation

struct KickoffSetupView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var gameStateManager: GameStateManager

    var game: Game

    @State private var kickingTeamIsHome: Bool = true
    @State private var directionIsLTR: Bool = true

    var body: some View {
        Form {
            Section(header: Text("Kicking Team")) {
                Picker("Kicking Team", selection: $kickingTeamIsHome) {
                    Text("Home: \(game.isHome ? (game.team?.teamInfo.displayName ?? "My Team") : (game.opponentTeam?.displayName ?? game.opponentName))").tag(true)
                    Text("Visitor: \(game.isHome ? (game.opponentTeam?.displayName ?? game.opponentName) : (game.team?.teamInfo.displayName ?? "My Team"))").tag(false)
                }
                .pickerStyle(.segmented)
            }

            Section(header: Text("Field Direction")) {
                Picker("Direction", selection: $directionIsLTR) {
                    Text("Left to Right").tag(true)
                    Text("Right to Left").tag(false)
                }
                .pickerStyle(.segmented)
            }

            Section {
                Button("Start Game") {
                    gameStateManager.startGame(game, context: modelContext)
                    dismiss()
                }
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .navigationTitle("Kickoff Setup")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let game = Game(date: .now, opponentName: "Bear River", isHome: true)
    return NavigationStack {
        KickoffSetupView(game: game)
    }
    .environmentObject(GameStateManager())
    .modelContainer(for: Game.self)
}
