//
//  GameListView.swift
//  FootballStatsV3
//
//  Created by Aaron Bodell on 7/23/25.
//


import SwiftUI
import SwiftData

struct GameListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Game.date, order: .reverse) private var games: [Game]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(games) { game in
                    NavigationLink {
                        if game.isComplete {
                            GameSummaryView(game: game)
                        } else if game.plays.isEmpty {
                            KickoffSetupView(game: game)
                        } else {
                            ActiveGameView()
                        }
                    } label: {
                        VStack(alignment: .leading) {
                            Text(game.displayName)
                                .font(.headline)
                            if game.isComplete {
                                Text("Final").foregroundColor(.secondary)
                            } else {
                                Text("In Progress").foregroundColor(.blue)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteGames)
            }
            .navigationTitle("Games")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        addGame()
                    } label: {
                        Label("Add Game", systemImage: "plus")
                    }
                }
            }
        }
    }
    private func deleteGames(at offsets: IndexSet) {
        for index in offsets {
            let game = games[index]
            modelContext.delete(game)
        }
        try? modelContext.save()
    }

    private func addGame() {
        let newGame = Game(
            date: .now,
            opponentName: "New Opponent",
            isHome: true
        )
        modelContext.insert(newGame)
        try? modelContext.save()
    }
}


#Preview {
    GameListView()
        .environmentObject(GameStateManager())
        .modelContainer(for: [Game.self])
}

// Stub views to avoid build errors
struct GameSummaryView: View {
    var game: Game
    var body: some View { Text("Game Summary: \(game.displayName)") }
}
