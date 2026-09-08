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

    init() {
        loadGames()
    }

    private func loadGames() {
        games = MockFootballData.weeklyGames
    }
}
