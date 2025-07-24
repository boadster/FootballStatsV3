//
//  GameStateView.swift
//  FootballStats2
//

import SwiftUI
import Foundation
import SwiftData
//import Extensions

struct GameStateView: View {
    @EnvironmentObject var gameState: GameStateManager

    var body: some View {
        VStack(spacing: 16) {
            // Scoreboard
            HStack {
                Text(gameState.leftTeamLabel)
                    .fontWeight(.bold)
                Spacer()
                Text("Q\(gameState.quarter)")
                    .foregroundColor(.secondary)
                    .fontWeight(.semibold)
                Spacer()
                Text(gameState.rightTeamLabel)
                    .fontWeight(.bold)
            }
            .padding(.horizontal)

            // Field progress bar (always grows from the side of the team with the ball)
            GeometryReader { geometry in
                let offenseIsOnLeft = gameState.offenseIsOnLeft
                ZStack(alignment: offenseIsOnLeft ? .leading : .trailing) {
                    Capsule()
                        .frame(height: 10)
                        .foregroundColor(.gray.opacity(0.3))
                    Capsule()
                        .fill(Color(hex: gameState.possessionTeamColorHex))
                        .frame(
                            width: geometry.size.width
                                * PossessionUtils.yardlineProgress(
                                    ballOn: Int(gameState.ballOn),
                                    offenseIsOnLeft: gameState.offenseIsOnLeft
                                ),
                            height: 10
                        )
                }
                .padding(.horizontal)
            }
            .frame(height: 10)

            // Example yardline display
            Text(PossessionUtils.formattedYardline(
                ballOn: Int(gameState.ballOn),
                offenseIsOnLeft: gameState.offenseIsOnLeft
            ))
            .font(.headline)
            .padding(.top, 8)

            // ...rest of your GameStateView (clock, down/distance, etc.)
        }
        .padding(.vertical)
    }
}

// MARK: - Preview
#Preview {
    GameStateView()
        .environmentObject(GameStateManager(preview: true))
}
