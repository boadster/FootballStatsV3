//
//  ActiveGameView.swift
//  FootballStatsV3
//
//  Created by Aaron Bodell on 7/23/25.
//


import SwiftUI
import SwiftData

enum PlayPhase: String, CaseIterable, Identifiable {
    case offense = "Offense"
    case defense = "Defense"
    case specialTeams = "Special Teams"
    case admin = "Admin"

    var id: String { self.rawValue }
}

struct ActiveGameView: View {
    @EnvironmentObject var gameStateManager: GameStateManager
    @State private var selectedPhase: PlayPhase = .offense

    var body: some View {
        VStack {
            // Game HUD
            GameStateView()

            // Play phase selector
            Picker("Phase", selection: $selectedPhase) {
                ForEach(PlayPhase.allCases) { phase in
                    Text(phase.rawValue).tag(phase)
                }
            }
            .pickerStyle(.segmented)
            .padding()

            // Dynamic entry view
            Group {
                switch selectedPhase {
                case .offense:
                    OffensePlayEntryView()
                case .defense:
                    DefensePlayEntryView()
                case .specialTeams:
                    SpecialTeamsPlayEntryView()
                case .admin:
                    AdminPlayEntryView()
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .navigationTitle("Game On")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let game = Game(date: .now, opponentName: "Bear River", isHome: true)
    let manager = GameStateManager(currentGame: game)
    return NavigationStack {
        ActiveGameView()
            .environmentObject(manager)
    }
    .modelContainer(for: [Game.self])
}

// Placeholder subviews
struct OffensePlayEntryView: View {
    var body: some View { Text("Offensive Play Entry") }
}

struct DefensePlayEntryView: View {
    var body: some View { Text("Defensive Play Entry") }
}

struct SpecialTeamsPlayEntryView: View {
    var body: some View { Text("Special Teams Entry") }
}

struct AdminPlayEntryView: View {
    var body: some View { Text("Admin Entry") }
}
