//
//  FootballStatsV3Tests.swift
//  FootballStatsV3Tests
//
//  Created by Aaron Bodell on 7/23/25.
//

import XCTest
import SwiftData
@testable import FootballStatsV3

@MainActor
final class ModelPersistenceTests: XCTestCase {
    var modelContainer: ModelContainer!
    var modelContext: ModelContext!

    override func setUpWithError() throws {
        modelContainer = try ModelContainer(for: Game.self, Play.self, Player.self, Team.self, configurations:
                                                ModelConfiguration(isStoredInMemoryOnly: true)
        )
        modelContext = modelContainer.mainContext
    }

    func testGameAndPlayPersistence() throws {
        let game = Game(
            date: Date(timeIntervalSince1970: 1_751_000_000), // Sep 1, 2025
            opponentName: "Bear River",
            isHome: true
        )

        let play = Play(
            playType: .rush,
            playResult: .touchdown,
            startYardline: 35,
            endYardline: 50,
            gameID: game.id
        )

        game.plays.append(play)
        modelContext.insert(game)
        modelContext.insert(play)
        try modelContext.save()

        // Fetch all games
        let descriptor = FetchDescriptor<Game>()
        let fetchedGames = try modelContext.fetch(descriptor)

        XCTAssertEqual(fetchedGames.count, 1)
        XCTAssertEqual(fetchedGames[0].opponentName, "Bear River")
        XCTAssertEqual(fetchedGames[0].displayName.contains("Bear River"), true)

        // Validate play is linked correctly
        let savedPlays = fetchedGames[0].plays
        XCTAssertEqual(savedPlays.count, 1)
        XCTAssertEqual(savedPlays[0].yardage, 15)
        XCTAssertEqual(savedPlays[0].playResult, .touchdown)
    }
    
    func testTeamPersistence() throws {
        let teamInfo = TeamInfo(
            schoolName: "Grantsville High",
            mascot: "Cowboys",
            shortName: "GHS",
            city: "Grantsville",
            state: "UT"
        )

        let team = Team(teamInfo: teamInfo, isUserTeam: true)
        modelContext.insert(team)
        try modelContext.save()

        let descriptor = FetchDescriptor<Team>()
        let fetchedTeams = try modelContext.fetch(descriptor)
        print(fetchedTeams)
        XCTAssertGreaterThan(fetchedTeams.count, 0, "No teams were fetched")
        guard let fetchedTeam = fetchedTeams.first else {
            XCTFail("Expected at least one team, but found none")
            return
        }
        XCTAssertEqual(fetchedTeam.teamInfo.schoolName, "Grantsville High")
        XCTAssertTrue(fetchedTeam.isUserTeam)
    }

    func testPlayerPersistence() throws {
        // First, insert a team so the player has a valid teamID
        let team = Team(teamInfo: TeamInfo(
            schoolName: "Grantsville High",
            mascot: "Cowboys",
            shortName: "GHS",
            city: "Grantsville",
            state: "UT"
        ), isUserTeam: true)

        modelContext.insert(team)
        try modelContext.save()

        let player = Player(
            firstName: "John",
            lastName: "Doe",
            jerseyNumber: 12,
            position: "QB",
            height: "6'1\"",
            weight: "190",
            gradeLevel: "12",
            teamID: team.id
        )

        modelContext.insert(player)
        try modelContext.save()

        let descriptor = FetchDescriptor<Player>()
        let fetchedPlayers = try modelContext.fetch(descriptor)
        XCTAssertGreaterThan(fetchedPlayers.count, 0, "No players were fetched")
        guard let fetchedPlayer = fetchedPlayers.first else {
            XCTFail("Expected at least one player, but found none")
            return
        }
        XCTAssertEqual(fetchedPlayer.fullName, "John Doe")
        XCTAssertEqual(fetchedPlayer.position, "QB")
        XCTAssertEqual(fetchedPlayer.teamID, team.id)
    }
}
