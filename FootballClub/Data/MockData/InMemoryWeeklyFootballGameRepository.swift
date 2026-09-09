//
//  InMemoryWeeklyFootballGameRepository.swift
//  FootballClub
//
//  Created by Đức Anh on 9/9/26.
//

import Foundation

final class InMemoryWeeklyFootballGameRepository: WeeklyFootballGameRepository {

    private let storedGames: [WeeklyFootballGame]

    init(games: [WeeklyFootballGame]) {
        self.storedGames = games
    }

    func allGames() -> [WeeklyFootballGame] {
        storedGames
    }

    func game(
        withID weeklyGameID: UUID
    ) -> WeeklyFootballGame? {
        storedGames.first {
            $0.id == weeklyGameID
        }
    }
}
