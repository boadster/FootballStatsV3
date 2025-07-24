//
//  GameStateManager.swift
//  FootballStatsV3
//
//  Created by Aaron Bodell on 7/23/25.
//


import Foundation
import SwiftData

@MainActor
class GameStateManager: ObservableObject {
    @Published var currentGame: Game?
    @Published var currentPlay: Play?

    // Game state
    @Published var quarter: Int = 1
    @Published var ballOn: Int = 40
    @Published var down: Int = 1
    @Published var distance: Int = 10
    @Published var possessionTeamId: UUID?
    @Published var isLTR: Bool = true

    // Injected context (optional, can also be passed on save)
    var modelContext: ModelContext?

    var myTeam: Team? {
        currentGame?.team
    }

    var opponentTeamInfo: TeamInfo? {
        currentGame?.opponentTeam
    }

    var leftTeamLabel: String {
        let myLabel = myTeam?.teamInfo.displayName ?? "My Team"
        let opponentLabel = opponentTeamInfo?.displayName ?? currentGame?.opponentName ?? "Opponent"
        return isLTR ? myLabel : opponentLabel
    }

    var rightTeamLabel: String {
        let myLabel = myTeam?.teamInfo.displayName ?? "My Team"
        let opponentLabel = opponentTeamInfo?.displayName ?? currentGame?.opponentName ?? "Opponent"
        return isLTR ? opponentLabel : myLabel
    }

    init(currentGame: Game? = nil, modelContext: ModelContext? = nil) {
        self.currentGame = currentGame
        self.modelContext = modelContext
    }

    init(preview: Bool = false) {
        if preview {
            // Create a mock game with mock team data
            let myTeamInfo = TeamInfo(
                schoolName: "Grantsville High",
                mascot: "Cowboys",
                shortName: "GHS",
                city: "Grantsville",
                state: "UT",
                classification: "3A",
                region: "Region 10",
                colorPrimaryHex: "#003366",
                colorSecondaryHex: "#CC0000"
            )

            let opponentInfo = TeamInfo(
                schoolName: "Morgan High",
                mascot: "Trojans",
                shortName: "Morgan",
                city: "Morgan",
                state: "UT",
                classification: "3A",
                region: "Region 10",
                colorPrimaryHex: "#551A8B",
                colorSecondaryHex: "#FFCC00"
            )

            let myTeam = Team(teamInfo: myTeamInfo)
            let game = Game(date: .now, opponentName: "Morgan", isHome: true, team: myTeam)
            game.opponentTeam = opponentInfo

            self.currentGame = game
            self.quarter = 1
            self.ballOn = 40
            self.down = 1
            self.distance = 10
            self.isLTR = true
            self.possessionTeamId = myTeam.id
        }
    }

    func startGame(_ game: Game, context: ModelContext) {
        self.modelContext = context
        self.currentGame = game
        self.quarter = 1
        self.ballOn = 40
        self.down = 1
        self.distance = 10
        self.isLTR = true
    }

    func savePlay(_ play: Play) {
        guard let context = modelContext else {
            print("❌ No model context available for saving play")
            return
        }

        currentGame?.plays.append(play) // In-memory
        context.insert(play)

        do {
            try context.save()
        } catch {
            print("❌ Failed to save play: \(error)")
        }
    }

    func advanceDown() {
        if down < 4 {
            down += 1
        } else {
            turnoverOnDowns()
        }
    }

    func turnoverOnDowns() {
        // Flip possession, reset down/distance, mirror ballOn if needed
    }

    // Add other game logic here...

    var offenseIsOnLeft: Bool {
        if possessionTeamId == myTeam?.id {
            return isLTR
        } else {
            return !isLTR
        }
    }

    var possessionTeamColorHex: String {
        if possessionTeamId == myTeam?.id {
            return myTeam?.teamInfo.colorPrimaryHex ?? "#000000"
        } else {
            return opponentTeamInfo?.colorPrimaryHex ?? "#000000"
        }
    }
}
