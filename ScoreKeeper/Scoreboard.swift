//
//  Scoreboard.swift
//  ScoreKeeper
//
//  Created by Jean on 18/10/24.
//

import Foundation

struct Scoreboard {
    var players: [Player] = [
        Player(name: "Elisha", score: 0),
        Player(name: "Andre", score: 0),
        Player(name: "Jasmine", score: 0),
    ]

    var state = GameState.setup
    var doesHighestScoreWin = true

    var winners: [Player] {
        guard state == .gameOver else { return [] }

        var winningScore = 0
        if doesHighestScoreWin {
            winningScore = Int.min
            for player in players {
                winningScore = max(winningScore, player.score)
            }
        } else {
            winningScore = Int.max
            for player in players {
                winningScore = min(winningScore, player.score)
            }
        }
        return players.filter { player in player.score == winningScore }
    }

    mutating func resetScores(to newValue: Int) {
        for index in 0..<players.count {
            players[index].score = newValue
        }
    }
}
