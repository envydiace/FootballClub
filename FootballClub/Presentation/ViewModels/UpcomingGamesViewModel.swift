//
//  UpcomingGamesViewModel.swift
//  FootballClub
//
//  Created by Đức Anh on 8/9/26.
//

import Foundation
import Observation

@Observable
final class UpcomingGamesViewModel {

    var games: [WeeklyFootballGame] = []

    private let repository: WeeklyFootballGameRepository

    init(
        repository: WeeklyFootballGameRepository
    ) {
        self.repository = repository
        loadGames()
    }

    private func loadGames() {
        games = repository.allGames()
    }
}
